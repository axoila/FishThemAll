extends Node2D


func _ready():
	game_manager.connect("reset", self, "update_display")

func update_display():
	print("update display")
	
	for c in get_children():
		c.queue_free()
	
	for fish in game_manager.catched_fishes:
		var new_fish = fish.duplicate()
		add_child(new_fish)
		new_fish.catched = true
		new_fish.set_pos(get_pos())
		new_fish.set_rot(rand_range(PI/4, 3*PI/4))