class_name HoneyBeehive extends Beehive


func harvest_from_object():
	harvested.emit("honey beehive", randf_range(1, 5))
