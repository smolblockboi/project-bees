extends Node


var total_pollen : int
var total_nectar : int
var total_honey : int
var total_royal_jelly : int


func _on_object_harvested(id : String, amount : int):
	match id:
		"beehive":
			gain_pollen(amount)
			gain_nectar(amount)
		"honey beehive":
			lose_pollen(amount)
			lose_nectar(amount)
			gain_honey(amount * 0.8)
		"royal jelly beehive":
			lose_pollen(amount * 0.5)
			lose_nectar(amount * 0.5)
			lose_honey(amount)
			gain_royal_jelly(amount * 0.5)


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
