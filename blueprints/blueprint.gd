extends Sprite2D


@export var blueprint_data : BlueprintData

@export var interact_button : InteractButton
@export var trait_handler : TraitHandler
@export var production_timer : ProductionTimer

@onready var resource_progress_bar: ProgressBar = %ResourceProgressBar


var ready_to_build : bool


func _ready() -> void:
	set_is_disabled_from_tile_map_layer(bool(get_parent().placement_mode))


func _process(delta: float) -> void:
	resource_progress_bar.value = production_timer.wait_time - production_timer.time_left


func set_is_disabled_from_tile_map_layer(is_true : bool):
	interact_button.set_disabled(is_true)
	if interact_button.is_disabled():
		interact_button.set_focus_mode(Control.FOCUS_NONE)
	else:
		interact_button.set_focus_mode(Control.FOCUS_ALL)


func _on_interact_pressed():
	if ready_to_build:
		return
	
	if production_timer.is_stopped():
		production_timer.wait_time = 5.0
		
		resource_progress_bar.value = 0
		resource_progress_bar.max_value = production_timer.wait_time
		
		production_timer.start_production()


func emulate_interact_press():
	interact_button.pressed.emit()


func _on_production_started():
	ready_to_build = false


func _on_production_ticked():
	pass


func _on_production_finished():
	ready_to_build = true
	
	await get_tree().create_timer(1.0).timeout
	
	var spawned_object = ScenesManager.build_from_blueprint(blueprint_data.scene)
	add_sibling(spawned_object)
	spawned_object.global_position = global_position
	
	queue_free()
