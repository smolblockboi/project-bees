extends Node2D


@export var camera : Camera2D
@export var camera_move_speed : float

var screen_center : Vector2

var selected_hud_item : String


func _ready() -> void:
	screen_center = get_viewport().size * 0.25
	print(screen_center)


func _physics_process(delta: float) -> void:
	var camera_move_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	camera.global_position += (camera_move_input * camera_move_speed)


func _input(event: InputEvent) -> void:
	var zoom_input = Input.get_axis("zoom_out", "zoom_in")
	if zoom_input:
		if zoom_input < 0:
			camera.zoom = Vector2.ONE
			#camera.global_position = screen_center
		elif zoom_input > 0:
			if camera.zoom != Vector2.ONE * 2.0:
				camera.global_position = get_global_mouse_position()
				camera.zoom = Vector2.ONE * 2.0


func _on_hud_item_button_pressed(item_id : String):
	selected_hud_item = item_id
