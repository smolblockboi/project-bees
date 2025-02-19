extends Sprite2D


@export var trait_handler : TraitHandler


func _on_interact_pressed():
	print("a nice flower")
	if !trait_handler:
		push_error("%s missing trait handler" % self.name)
		return


func _on_interact_hovered():
	var new_tooltip_info = trait_handler.get_total_traits_mod().duplicate()
	new_tooltip_info["name"] = name
	return new_tooltip_info
