extends Node


const BEEHIVE = preload("res://beehives/beehive.tscn")

const FLOWER = preload("res://flower.tscn")


const INTERACT_TOOLTIP_PANEL = preload("res://gui/interact_tooltip_panel.tscn")


func build_from_blueprint(build_string : String):
	match build_string:
		"beehive":
			return BEEHIVE.instantiate()
		"flower":
			return FLOWER.instantiate()


func get_new_flower():
	return FLOWER.instantiate()


func get_new_tooltip_panel():
	return INTERACT_TOOLTIP_PANEL.instantiate()
