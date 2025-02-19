extends Node


const BEEHIVE = preload("res://beehive.tscn")

const FLOWER = preload("res://flower.tscn")


const INTERACT_TOOLTIP_PANEL = preload("res://gui/interact_tooltip_panel.tscn")


func get_new_beehive():
	return BEEHIVE.instantiate()


func get_new_flower():
	return FLOWER.instantiate()


func get_new_tooltip_panel():
	return INTERACT_TOOLTIP_PANEL.instantiate()
