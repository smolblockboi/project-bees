class_name Beehive extends Sprite2D


signal harvested
signal requested_ingredients

@export var object_id : String = "beehive"

@export var interact_button : InteractButton
@export var trait_handler : TraitHandler
@export var production_timer: ProductionTimer

@onready var resource_progress_bar: ProgressBar = %ResourceProgressBar
@onready var bees_particles: GPUParticles2D = %BeesParticles

@onready var flower_raycasts: Node2D = %FlowerRaycasts


var ready_to_harvest : bool


func _ready() -> void:
	bees_particles.set_emitting(false)
	
	harvested.connect(StatTracker._on_object_harvested)
	requested_ingredients.connect(StatTracker._on_ingredients_requested_started)


func _process(delta: float) -> void:
	resource_progress_bar.value = production_timer.wait_time - production_timer.time_left
	
	resource_progress_bar.set_visible(!production_timer.is_stopped() or ready_to_harvest)


func harvest_from_object():
	harvested.emit(object_id, 1)
	ready_to_harvest = false


func emulate_interact_press():
	interact_button.pressed.emit()


func _on_interact_pressed():
	if ready_to_harvest:
		harvest_from_object()
	
	if production_timer.is_stopped():
		production_timer.wait_time = 5.0 / trait_handler.get_total_traits_mod().get("production rate")
		
		resource_progress_bar.value = 0
		resource_progress_bar.max_value = production_timer.wait_time
		
		if !StatTracker.has_enough_resource(object_id):
			print("Not enough resources for %s!" % object_id)
			return
		
		production_timer.start_production()
		bees_particles.set_emitting(true)


func _on_production_started():
	requested_ingredients.emit(object_id, 1)


func _on_production_ticked():
	trait_handler.get_total_traits_mod()


func _on_production_finished():
	bees_particles.set_emitting(false)
	ready_to_harvest = true
