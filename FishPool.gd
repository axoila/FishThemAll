extends Node

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func get_fish(depth):
	var index = floor(rand_range(0, get_child_count()))
	var new_fish = get_child(index).duplicate()
	remove_child(new_fish)
	return new_fish