class_name TraitHandler extends Node


@export var raycast_root : Node2D

@export var base_traits : Array[Trait]
@export var traits : Array[Trait]


func _ready() -> void:
	traits = base_traits.duplicate()


func reset_traits():
	traits = base_traits.duplicate()


func merge_traits(new_traits):
	for i in new_traits:
		traits.append(i)


func get_owner_trait_mods():
	var trait_dict : Dictionary
	for i in traits:
		if !trait_dict.get(i.trait_name):
			trait_dict[i.trait_name] = i.trait_value
		else:
			trait_dict[i.trait_name] += i.trait_value
	
	return trait_dict


func get_surrounding_trait_mods():
	var trait_dict : Dictionary
	if raycast_root:
		for i in raycast_root.get_children():
			if i.is_colliding():
				var object = i.get_collider().get_parent()
				var object_traits = object.trait_handler.traits
				for j in object_traits:
					if !trait_dict.get(j.trait_name):
						trait_dict[j.trait_name] = j.trait_value
					else:
						trait_dict[j.trait_name] += j.trait_value
	
	return trait_dict


func get_total_traits_mod():
	var total_dict : Dictionary = {}
	var owner_dict : Dictionary = get_owner_trait_mods()
	var surrounding_dict : Dictionary = get_surrounding_trait_mods()
	
	if surrounding_dict.size() > 0:
		for i in surrounding_dict:
			if owner_dict.get(i) and surrounding_dict.get(i):
				total_dict[i] = owner_dict[i] + surrounding_dict[i]
			else:
				total_dict[i] = surrounding_dict.get(i)
		for i in owner_dict:
			if !total_dict.get(i):
				total_dict[i] = owner_dict.get(i)
	else:
		total_dict = owner_dict.duplicate()
	
	return total_dict
