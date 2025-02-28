class_name Decoration extends Sprite2D


@export var object_id : String = "beehive"

@export var interact_button : InteractButton
@export var trait_handler : TraitHandler


func _ready() -> void:
	set_is_disabled_from_tile_map_layer(bool(get_parent().placement_mode))


func set_is_disabled_from_tile_map_layer(is_true : bool):
	interact_button.set_disabled(is_true)
	if interact_button.is_disabled():
		interact_button.set_focus_mode(Control.FOCUS_NONE)
	else:
		interact_button.set_focus_mode(Control.FOCUS_ALL)


func _on_interact_pressed():
	pass
