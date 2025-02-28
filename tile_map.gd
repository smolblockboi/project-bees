extends TileMapLayer


@export var grid_cursor : Sprite2D

var beekeepers : Array
var decorations : Array

enum PlacementMode {NORMAL, SHOP}
var placement_mode : PlacementMode = PlacementMode.NORMAL:
	set(new_mode):
		placement_mode = new_mode
		set_interactable_objects_disabled(bool(placement_mode))


func _physics_process(delta: float) -> void:
	beekeepers = get_tree().get_nodes_in_group("beekeepers")
	decorations = get_tree().get_nodes_in_group("decorations")


func _input(event: InputEvent) -> void:
	grid_cursor.global_position = (local_to_map(get_global_mouse_position()) * tile_set.tile_size) + Vector2i(tile_set.tile_size * 0.5)
	
	if Input.is_action_just_pressed("right_click"):
		get_viewport().gui_release_focus()
		change_placement_mode_to(PlacementMode.NORMAL) # NORMAL
		get_parent().selected_hud_item = ""


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		var clicked_tile_position = local_to_map(get_global_mouse_position())
		var tile_center = (clicked_tile_position * tile_set.tile_size) + Vector2i(tile_set.tile_size * 0.5)
		
		var gui_focus = get_viewport().gui_get_focus_owner()
		
		if !gui_focus:
			if get_parent().selected_hud_item:
				var new_item = ScenesManager.get_new_blueprint(get_parent().selected_hud_item)
				add_child(new_item)
				new_item.position = tile_center
		else:
			if gui_focus.get_parent() is not Beekeeper:
				gui_focus.release_focus()
			else:
				gui_focus.get_parent().start_walk_to_destination(tile_center)
		
		print("clicked tile %s" % local_to_map(get_global_mouse_position()))
	
	if Input.is_action_just_pressed("ui_accept"):
		for i in get_children():
			var interact_button = i.get_node_or_null("InteractButton")
			if interact_button:
				interact_button.pressed.emit()


func change_placement_mode_to(new_mode : PlacementMode):
	match new_mode:
		PlacementMode.NORMAL:
			placement_mode = PlacementMode.NORMAL
		PlacementMode.SHOP:
			placement_mode = PlacementMode.SHOP


func set_interactable_objects_disabled(is_true : bool):
	for object in get_children():
		object.set_is_disabled_from_tile_map_layer(is_true)
