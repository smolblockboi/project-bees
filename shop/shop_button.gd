extends Button


@export var item_id : String
@export var item_icon : Texture2D:
	set(new_texture):
		item_icon = new_texture
		icon = item_icon


func _ready() -> void:
	icon = item_icon
