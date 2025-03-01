class_name AdjacentRaycasts extends Node2D


@export_flags_2d_physics var mask : int


func _ready() -> void:
	update_collision_masks(mask)


func update_collision_masks(new_mask : int):
	for i in get_children():
		i = i as RayCast2D
		i.set_collision_mask(new_mask)


func get_adjacent_colliders():
	var colliders : Array
	for i in get_children():
		i = i as RayCast2D
		if i.get_collider():
			colliders.append(i.get_collider())
	return colliders


func get_adjacent_objects():
	var objects : Array
	for i in get_children():
		i = i as RayCast2D
		if i.get_collider():
			objects.append(i.get_collider().owner)
	return objects
