class_name Beekeeper extends AnimatedSprite2D


signal finished_moving


@export var trait_handler : TraitHandler

@onready var adjacent_raycasts: Node2D = %AdjacentRaycasts

@export var move_speed : float = 50.0

@onready var auto_interact_timer: Timer = %AutoInteractTimer


var is_moving : bool
var current_destination : Vector2


func _ready() -> void:
	finished_moving.connect(_on_finished_walking)
	
	animation_finished.connect(_on_sprite_animation_finished)
	
	auto_interact_timer.timeout.connect(_on_auto_interact_timeout)


func _physics_process(delta: float) -> void:
	if is_moving:
		walk_to_destination(current_destination)
	
	if trait_handler.get_total_traits_mod().get("bench"):
		auto_interact_timer.wait_time = 5 - trait_handler.get_total_traits_mod().get("bench")
	else:
		auto_interact_timer.wait_time = 5


func _on_interact_pressed():
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
		global_position = global_position.move_toward(destination, get_physics_process_delta_time() * move_speed)
	else:
		is_moving = false
		current_destination = global_position
		finished_moving.emit()


func get_surrounding_objects():
	var objects = []
	for i in adjacent_raycasts.get_children():
		if i.is_colliding():
			objects.append(i.get_collider().get_parent())
	return objects


func get_surrounding_object_count():
	var count = 0
	for i in adjacent_raycasts.get_children():
		if i.is_colliding():
			count += 1
	return count


func interact_with_neighbors_start():
	play("idle")
	var neighbors = get_surrounding_objects()
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
		var neighbors = get_surrounding_objects()
		for i in neighbors:
			i.emulate_interact_press()
			print("%s interacted with %s" % [name, i.name])
		auto_interact_timer.start()


func _on_auto_interact_timeout():
	if !is_moving:
		print("%s auto interacted" % name)
		interact_with_neighbors_start()
