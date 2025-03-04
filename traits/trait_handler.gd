class_name TraitHandler extends Node


@export var adjacent_raycasts : AdjacentRaycasts

@export var base_traits : Array[Trait]

var total_traits : Dictionary

var last_object_check : Array


func _ready() -> void:
	reset_traits()


func reset_traits():
	total_traits.clear()
	
	for t in base_traits:
		add_trait(t)


func get_surrounding_object_traits():
	var objects = adjacent_raycasts.get_adjacent_objects()
	if last_object_check == objects:
		return
	
	reset_traits()
	
	last_object_check = objects
	for i in objects:
		for t in i.trait_handler.get_base_traits():
			add_trait(t)


func add_trait(new_trait = Trait):
	if total_traits.has(new_trait.trait_name):
		total_traits[new_trait.trait_name] += new_trait.trait_quantity
	else:
		total_traits[new_trait.trait_name] = new_trait.trait_quantity


func get_trait_dict_quantity(trait_string : String):
	if total_traits.get(trait_string):
		return total_traits.get(trait_string)
	else:
		return 0


func get_base_traits():
	return base_traits


func get_total_traits():
	return total_traits
