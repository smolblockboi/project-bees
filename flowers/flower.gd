class_name Flower extends Sprite2D

@export var object_id : String
@export var trait_handler : TraitHandler
@export var interact_button : InteractButton


func _on_interact_pressed():
	if !trait_handler:
		push_error("%s missing trait handler" % self.name)
		return


func _on_interact_hovered():
	var new_tooltip_info = trait_handler.get_total_traits_mod().duplicate()
	new_tooltip_info["name"] = name
	return new_tooltip_info


func set_is_disabled_from_tile_map_layer(is_true : bool):
	interact_button.set_disabled(is_true)
	if interact_button.is_disabled():
		interact_button.set_focus_mode(Control.FOCUS_NONE)
	else:
		interact_button.set_focus_mode(Control.FOCUS_ALL)
