class_name TraitHandler extends Node

signal total_traits_updated

@export var adjacent_raycasts : AdjacentRaycasts

@export var base_traits : Array[TraitSlot]
var total_traits : Array[TraitSlot]

var total_traits_dict : Dictionary


func _ready() -> void:
	total_traits = base_traits.duplicate()


func reset_traits():
	total_traits = base_traits.duplicate()


func get_base_traits():
	return base_traits


func get_total_traits():
	return total_traits


func get_total_traits_as_dict():
	var new_dict : Dictionary
	for slot in total_traits:
		new_dict[slot.trait_resource.trait_name] = slot.quantity
	print(new_dict)
	return new_dict


func add_trait(new_trait : Trait):
	total_traits.append(new_trait)


func remove_trait(old_trait : Trait):
	total_traits.erase(old_trait)
