extends Node


var total_pollen : int
var total_nectar : int
var total_honey : int
var total_royal_jelly : int
var total_amber : int
var total_gem : int


func _on_object_harvested(id : String, amount : int):
	match id:
		"pollen_beehive":
			gain_pollen(amount)
			gain_nectar(amount)
		"honey_beehive":
			gain_honey(amount)
		"royal_jelly_beehive":
			gain_royal_jelly(amount)
		"amber_beehive":
			gain_amber(amount)
		"gem_beehive":
			gain_gem(amount)


func has_enough_resource(id : String):
	match id:
		"pollen_beehive":
			return true
		"honey_beehive":
			return (total_pollen > 0) and (total_nectar > 0)
		"royal_jelly_beehive":
			return (total_pollen > 0) and (total_nectar > 0) and (total_honey > 0)
		"amber_beehive":
			return (total_pollen > 0) and (total_nectar > 0) and (total_honey > 0) and (total_royal_jelly > 0)
		"gem_beehive":
			return (total_pollen > 0) and (total_nectar > 0) and (total_honey > 0) and (total_royal_jelly > 0) and (total_amber > 0)


func _on_ingredients_requested_started(id : String, amount : int):
	match id:
		"pollen_beehive":
			pass
		"honey_beehive":
			lose_pollen(amount)
			lose_nectar(amount)
		"royal_jelly_beehive":
			lose_pollen(amount)
			lose_nectar(amount)
			lose_honey(amount)
		"amber_beehive":
			lose_pollen(amount)
			lose_nectar(amount)
			lose_honey(amount)
			lose_royal_jelly(amount)
		"gem_beehive":
			lose_pollen(amount)
			lose_nectar(amount)
			lose_honey(amount)
			lose_royal_jelly(amount)
			lose_amber(amount)


func get_rand_amount(min : float, max : float):
	return randf_range(min, max)


func gain_pollen(amount : int):
	total_pollen += max(amount, 1)

func lose_pollen(amount : int):
	total_pollen -= max(amount, 1)


func gain_nectar(amount : int):
	total_nectar += max(amount, 1)

func lose_nectar(amount : int):
	total_nectar -= max(amount, 1)


func gain_honey(amount : int):
	total_honey += max(amount, 1)

func lose_honey(amount : int):
	total_honey -= max(amount, 1)


func gain_royal_jelly(amount : int):
	total_royal_jelly += max(amount, 1)

func lose_royal_jelly(amount : int):
	total_royal_jelly -= max(amount, 1) 


func gain_amber(amount : int):
	total_amber += max(amount, 1)

func lose_amber(amount : int):
	total_amber -= max(amount, 1)


func gain_gem(amount : int):
	total_gem += max(amount, 1)

func lose_gem(amount : int):
	total_gem -= max(amount, 1)
