class_name InteractButton extends Button


@export var parent : Node2D


func _ready() -> void:
	pressed.connect(parent._on_interact_pressed)
	mouse_entered.connect(_on_hovered)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and has_focus():
		parent.queue_free()


func update_tooltip(dict : Dictionary):
	var header_text = dict.get("name")
	dict.erase("name")
	var body_text = ""
	for i in dict:
		body_text += "%s: %s\n" % [i, dict[i]]
		
	tooltip_text = "%s\n%s" % [header_text, body_text]


func _on_hovered():
	var new_tooltip_info = parent.trait_handler.get_total_traits_mod().duplicate()
	new_tooltip_info["name"] = parent.name
	update_tooltip(new_tooltip_info)


func _make_custom_tooltip(for_text : String):
	var new_tooltip = ScenesManager.get_new_tooltip_panel()
	var string_parse = for_text.split("\n")
	print(string_parse)
	new_tooltip.get_node("%NameLabel").text = "%s" % string_parse[0]
	new_tooltip.get_node("%InfoLabel").text = ""
	for i in string_parse:
		if i != string_parse[0]:
			new_tooltip.get_node("%InfoLabel").text += "%s\n" % i
	return new_tooltip
