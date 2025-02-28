extends Sprite2D


@onready var default_texture = texture


func change_icon_to(icon : Texture2D):
	texture = icon
	if texture != default_texture:
		modulate.a = 0.5
	else:
		modulate.a = 1.0
