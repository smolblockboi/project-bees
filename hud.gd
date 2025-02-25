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
		button.pressed.connect(get_parent()._on_hud_item_button_pressed.bind(button.item_id))


func _process(delta: float) -> void:
	pollen_label.text = "%d" % StatTracker.total_pollen
	nectar_label.text = "%d" % StatTracker.total_nectar
	honey_label.text = "%d" % StatTracker.total_honey
	royal_jelly_label.text = "%d" % StatTracker.total_royal_jelly
	amber_label.text = "%d" % StatTracker.total_amber
	gem_label.text = "%d" % StatTracker.total_gem
