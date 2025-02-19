extends CanvasLayer


@onready var pollen_label: Label = %PollenLabel
@onready var nectar_label: Label = %NectarLabel
@onready var honey_label: Label = %HoneyLabel
@onready var royal_jelly_label: Label = %RoyalJellyLabel


func _process(delta: float) -> void:
	pollen_label.text = "%d" % StatTracker.total_pollen
	nectar_label.text = "%d" % StatTracker.total_nectar
	honey_label.text = "%d" % StatTracker.total_honey
	royal_jelly_label.text = "%d" % StatTracker.total_royal_jelly
