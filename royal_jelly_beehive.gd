class_name RoyalJellyBeehive extends Beehive


func harvest_from_object():
	harvested.emit("royal jelly beehive", randf_range(1, 5))
