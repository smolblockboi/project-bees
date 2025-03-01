extends Node


@onready var beekeeper_scenes = {
	"_beekeeper" : preload("res://beekeepers/beekeeper.tscn"), 
}


@onready var beehive_scenes = {
	"_beehive" : preload("res://beehives/beehive.tscn"), 
	"honey_beehive" : preload("res://beehives/honey_beehive.tscn"), 
	"royal_jelly_beehive" : preload("res://beehives/royal_jelly_beehive.tscn"), 
	"amber_beehive" : preload("res://beehives/amber_beehive.tscn"), 
	"gem_beehive" : preload("res://beehives/gem_beehive.tscn"), 
}

@onready var flower_scenes = {
	"red_flower" : preload("res://flowers/red_flower.tscn"), 
	"orange_flower" : preload("res://flowers/orange_flower.tscn"), 
	"green_flower" : preload("res://flowers/green_flower.tscn"), 
	"blue_flower" : preload("res://flowers/blue_flower.tscn"), 
	"cyan_flower" : preload("res://flowers/cyan_flower.tscn"), 
	"pink_flower" : preload("res://flowers/pink_flower.tscn"), 
	"white_flower" : preload("res://flowers/white_flower.tscn"), 
	"black_flower" : preload("res://flowers/black_flower.tscn"), 
}


@onready var blueprint_scenes = {
	"beekeeper" : preload("res://blueprints/beekeeper_blueprint.tscn"), 
	"flower" : preload("res://blueprints/flower_blueprint.tscn"), 
	"beehive" : preload("res://blueprints/blueprint.tscn"), 
}


const BLUEPRINT = preload("res://blueprints/blueprint.tscn")

const INTERACT_TOOLTIP_PANEL = preload("res://gui/interact_tooltip_panel.tscn")

const SHOP_BUTTON = preload("res://shop/shop_button.tscn")


func build_from_blueprint(build_string : String):
	prints("attempted to build", build_string, "from blueprint")
	if build_string.contains("_beekeeper"):
		return beekeeper_scenes.get(build_string).instantiate()
	if build_string.contains("_beehive"):
		return beehive_scenes.get(build_string).instantiate()
	if build_string.contains("_flower"):
		return flower_scenes.get(build_string).instantiate()


func get_new_blueprint(build_string : String):
	var new_blueprint
	
	if build_string.contains("beekeeper"):
		new_blueprint = blueprint_scenes.get("beekeeper").instantiate()
	if build_string.contains("beehive"):
		new_blueprint = blueprint_scenes.get("beehive").instantiate()
	if build_string.contains("flower"):
		new_blueprint = blueprint_scenes.get("flower").instantiate()
	
	new_blueprint.blueprint_data = BlueprintData.new()
	new_blueprint.blueprint_data.scene = build_string
	
	return new_blueprint


func get_new_tooltip_panel():
	return INTERACT_TOOLTIP_PANEL.instantiate() as InteractTooltipPanel
