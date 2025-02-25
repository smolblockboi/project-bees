extends Node


var total_pollen : int
var total_nectar : int
var total_honey : int
var total_royal_jelly : int
var total_amber : int
var total_gem : int


func _on_object_harvested(id : String, amount : int):
	match id:
		"beehive":
			gain_pollen(amount)
			gain_nectar(amount)
		"honey beehive":
			gain_honey(amount)
		"royal jelly beehive":
			gain_royal_jelly(amount)
		"amber beehive":
			gain_amber(amount)
		"gem beehive":
			gain_gem(amount)


func has_enough_resource(id : String):
	match id:
		"beehive":
			return true
		"honey beehive":
			return (total_pollen > 0) and (total_nectar > 0)
		"royal jelly beehive":
			return (total_pollen > 0) and (total_nectar > 0) and (total_honey > 0)
		"amber beehive":
			return (total_pollen > 0) and (total_nectar > 0) and (total_honey > 0) and (total_royal_jelly > 0)
		"gem beehive":
			return (total_pollen > 0) and (total_nectar > 0) and (total_honey > 0) and (total_royal_jelly > 0) and (total_amber > 0)


func _on_ingredients_requested_started(id : String, amount : int):
	match id:
		"beehive":
			pass
		"honey beehive":
			lose_pollen(amount)
			lose_nectar(amount)
		"royal jelly beehive":
			lose_pollen(amount)
			lose_nectar(amount)
			lose_honey(amount)
		"amber beehive":
			lose_pollen(amount)
			lose_nectar(amount)
			lose_honey(amount)
			lose_royal_jelly(amount)
		"gem beehive":
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
