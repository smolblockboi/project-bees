class_name InteractButton extends Button


signal emulated_pressed

@export var trait_handler : TraitHandler


func _ready() -> void:
	pressed.connect(get_parent()._on_interacted)
	emulated_pressed.connect(get_parent()._on_interacted)
	
	mouse_entered.connect(_on_hovered)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and has_focus():
		get_parent().queue_free()


func update_tooltip(dict : Dictionary):
	var header_text = dict.get("name")
	dict.erase("name")
	var body_text = ""
	for i in dict:
		body_text += "%s: %s\n" % [i, dict[i]]
		
	tooltip_text = "%s\n%s" % [header_text, body_text]


func _on_hovered():
	var new_tooltip_info : Dictionary 
	if get_parent() is Blueprint:
		new_tooltip_info["for"] = get_parent().blueprint_data.scene
	else:
		new_tooltip_info = trait_handler.get_total_traits_as_dict()
	new_tooltip_info["name"] = get_parent().name
	update_tooltip(new_tooltip_info)


func _make_custom_tooltip(for_text : String):
	var new_tooltip = ScenesManager.get_new_tooltip_panel()
	var string_parse = for_text.split("\n")
	new_tooltip.populate_panel(string_parse)
	return new_tooltip
