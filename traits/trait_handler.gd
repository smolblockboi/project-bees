class_name TraitHandler extends Node


@export var raycast_root : Node2D

@export var base_traits : Array[Trait]
@export var global_traits : Array[Trait]
@export var total_traits : Array[Trait]




func _ready() -> void:
	total_traits = base_traits.duplicate()


func reset_traits():
	total_traits = base_traits.duplicate()


func get_owner_trait_mods():
	var trait_dict : Dictionary
	for i in total_traits:
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
				var object_traits = object.trait_handler.total_traits
				for j in object_traits:
					if !trait_dict.get(j.trait_name):
						trait_dict[j.trait_name] = j.trait_value
					else:
						trait_dict[j.trait_name] += j.trait_value
	
	return trait_dict


func get_global_traits():
	var trait_dict : Dictionary
	if get_parent() is TileMapLayer:
		for decoration in get_parent().get_parent().decorations:
			for g_trait in decoration.trait_handler.global_traits:
				if !trait_dict.get(g_trait.trait_name):
					trait_dict[g_trait.trait_name] = g_trait.trait_value
				else:
					trait_dict[g_trait.trait_name] += g_trait.trait_value
	return trait_dict


func get_total_traits_mod():
	var total_dict : Dictionary = {}
	var owner_dict : Dictionary = get_owner_trait_mods()
	var surrounding_dict : Dictionary = get_surrounding_trait_mods()
	var global_dict : Dictionary = get_global_traits()
	
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
	
	if (get_parent() is Beekeeper) or (get_parent() is Decoration):
		if global_dict.size() > 0:
			for i in global_dict:
				if total_dict.get(i):
					total_dict[i] += global_dict.get(i)
				else:
					total_dict[i] = global_dict.get(i)
	
	return total_dict
