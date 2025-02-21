extends TileMapLayer


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("right_click"):
		get_viewport().gui_release_focus()


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		var gui_focus = get_viewport().gui_get_focus_owner()
		var clicked_tile_position = local_to_map(get_global_mouse_position())
		var tile_center = (clicked_tile_position * tile_set.tile_size) + Vector2i(tile_set.tile_size * 0.5)
		
		#TODO Make moving beekeeper not as sucky.
		
		if !gui_focus:
			var test = ScenesManager.get_new_flower()
			add_child(test)
			test.position = tile_center
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
