class_name Beehive extends Sprite2D


signal harvested


@export var trait_handler : TraitHandler
@export var production_timer: ProductionTimer

@onready var resource_progress_bar: ProgressBar = %ResourceProgressBar
@onready var bees_particles: GPUParticles2D = %BeesParticles

@onready var flower_raycasts: Node2D = %FlowerRaycasts


var object_id : String = "beehive"

var ready_to_harvest : bool


func _ready() -> void:
	bees_particles.set_emitting(false)
	
	harvested.connect(StatTracker._on_object_harvested)


func _process(delta: float) -> void:
	resource_progress_bar.value = production_timer.wait_time - production_timer.time_left


func harvest_from_object():
	harvested.emit(object_id, randf_range(1, 5))


func _on_interact_pressed():
	if ready_to_harvest:
		harvest_from_object()
	
	if production_timer.is_stopped():
		production_timer.wait_time = 5.0 / trait_handler.get_total_traits_mod().get("production rate")
		
		resource_progress_bar.value = 0
		resource_progress_bar.max_value = production_timer.wait_time
		
		production_timer.start_production()
		bees_particles.set_emitting(true)


func _on_production_started():
	ready_to_harvest = false


func _on_production_ticked():
	if trait_handler.get_total_traits_mod().get("beefiness"):
		self_modulate = Color.RED


func _on_production_finished():
	bees_particles.set_emitting(false)
	ready_to_harvest = true
	
	await get_tree().create_timer(1.0).timeout
	
	if trait_handler.get_total_traits_mod().get("automation"):
		_on_interact_pressed()
