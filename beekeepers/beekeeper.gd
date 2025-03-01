class_name Beekeeper extends AnimatedSprite2D


signal finished_moving

@export var object_id : String
@export var object_icon : Texture2D
@export var move_speed : float = 50.0

@export_category("Components")
@export var trait_handler : TraitHandler
@export var interact_button : InteractButton
@export var adjacent_raycasts : AdjacentRaycasts

@onready var auto_interact_timer: Timer = %AutoInteractTimer


var is_moving : bool
var current_destination : Vector2


func _ready() -> void:
	finished_moving.connect(_on_finished_walking)
	
	animation_finished.connect(_on_sprite_animation_finished)
	
	auto_interact_timer.timeout.connect(_on_auto_interact_timeout)
	
	if get_parent() is TileMapLayer:
		set_is_disabled_from_tile_map_layer(bool(get_parent().placement_mode))


func _physics_process(delta: float) -> void:
	if is_moving:
		walk_to_destination(current_destination)


func set_is_disabled_from_tile_map_layer(is_true : bool):
	interact_button.set_disabled(is_true)
	
	if interact_button.is_disabled():
		interact_button.set_focus_mode(Control.FOCUS_NONE)
	else:
		interact_button.set_focus_mode(Control.FOCUS_ALL)


func _on_interacted():
	print("poke")


func start_walk_to_destination(destination : Vector2):
	auto_interact_timer.stop()
	is_moving = global_position != destination
	current_destination = destination


func walk_to_destination(destination : Vector2):
	play("move")
	
	if global_position != destination:
		is_moving = true
		set_flip_h(destination.x <= global_position.x)
		global_position = global_position.move_toward(
			destination, get_physics_process_delta_time() * move_speed
			)
	else:
		is_moving = false
		current_destination = global_position
		finished_moving.emit()


func interact_with_neighbors_start():
	play("idle")
	var neighbors = adjacent_raycasts.get_adjacent_objects()
	if neighbors:
		for i in neighbors:
			set_flip_h(i.global_position.x < global_position.x)
			if is_flipped_h():
				break
		play("interact")


func _on_finished_walking():
	interact_with_neighbors_start()


func _on_sprite_animation_finished():
	var current_animation = get_animation()
	if current_animation == "interact":
		play("idle")
		var neighbors = adjacent_raycasts.get_adjacent_objects()
		for i in neighbors:
			i.emulate_interact_press()
			print("%s interacted with %s" % [name, i.name])
		auto_interact_timer.start()


func _on_auto_interact_timeout():
	if !is_moving:
		print("%s auto interacted" % name)
		interact_with_neighbors_start()
