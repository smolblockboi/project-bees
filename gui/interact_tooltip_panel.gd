class_name InteractTooltipPanel extends PanelContainer


@onready var name_label: Label = %NameLabel
@onready var info_label: Label = %InfoLabel


func populate_panel(string_array : Array[String]):
	await ready
	name_label.text = "%s" % string_array[0]
	info_label.text = ""
	for i in string_array:
		if i != string_array[0]:
			info_label.text += "%s\n" % i
