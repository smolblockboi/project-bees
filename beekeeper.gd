class_name Beekeeper extends Sprite2D


@export var trait_handler : TraitHandler

var is_moving : bool


func _on_interact_pressed():
	print("poke")


func walk_to_destination(destination : Vector2):
	global_position.move_toward(destination, get_physics_process_delta_time())
	
