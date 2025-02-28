extends CanvasLayer


@onready var pollen_label: Label = %PollenLabel
@onready var nectar_label: Label = %NectarLabel
@onready var honey_label: Label = %HoneyLabel
@onready var royal_jelly_label: Label = %RoyalJellyLabel
@onready var amber_label: Label = %AmberLabel
@onready var gem_label: Label = %GemLabel


@onready var shop_buttons_h_box: HBoxContainer = %ShopButtonsHBox


func _ready() -> void:
	for button in shop_buttons_h_box.get_children():
		button.pressed.connect(get_parent()._on_hud_item_button_pressed.bind(button.item_id, button.item_icon))
	
	get_beekeeper_scenes()
	get_beehive_scenes()
	get_flower_scenes()


func _process(delta: float) -> void:
	pollen_label.text = "%d" % StatTracker.total_pollen
	nectar_label.text = "%d" % StatTracker.total_nectar
	honey_label.text = "%d" % StatTracker.total_honey
	royal_jelly_label.text = "%d" % StatTracker.total_royal_jelly
	amber_label.text = "%d" % StatTracker.total_amber
	gem_label.text = "%d" % StatTracker.total_gem


func get_beekeeper_scenes():
	for i in ScenesManager.beekeeper_scenes:
		var new_button = ScenesManager.SHOP_BUTTON.instantiate()
		shop_buttons_h_box.add_child(new_button)
		
		var temp_scene = ScenesManager.beekeeper_scenes.get(i).instantiate()
		add_child(temp_scene)
		
		new_button.item_id = temp_scene.object_id
		
		if temp_scene is Sprite2D:
			new_button.item_icon = temp_scene.texture
		elif temp_scene is AnimatedSprite2D:
			new_button.item_icon = temp_scene.object_icon
		
		new_button.pressed.connect(
			get_parent()._on_hud_item_button_pressed.bind(new_button.item_id, new_button.item_icon)
		)
		
		temp_scene.queue_free()


func get_beehive_scenes():
	for i in ScenesManager.beehive_scenes:
		var new_button = ScenesManager.SHOP_BUTTON.instantiate()
		shop_buttons_h_box.add_child(new_button)
		
		var temp_scene = ScenesManager.beehive_scenes.get(i).instantiate()
		add_child(temp_scene)
		
		new_button.item_id = temp_scene.object_id
		new_button.item_icon = temp_scene.texture
		
		new_button.pressed.connect(
			get_parent()._on_hud_item_button_pressed.bind(new_button.item_id, new_button.item_icon)
		)
		
		temp_scene.queue_free()


func get_flower_scenes():
	for i in ScenesManager.flower_scenes:
		var new_button = ScenesManager.SHOP_BUTTON.instantiate()
		shop_buttons_h_box.add_child(new_button)
		
		var temp_scene = ScenesManager.flower_scenes.get(i).instantiate()
		add_child(temp_scene)
		
		new_button.item_id = temp_scene.object_id
		new_button.item_icon = temp_scene.texture
		
		new_button.pressed.connect(
			get_parent()._on_hud_item_button_pressed.bind(new_button.item_id, new_button.item_icon)
		)
		
		temp_scene.queue_free()
