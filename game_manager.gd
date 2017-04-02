extends Node

onready var cam = get_tree().get_nodes_in_group("Camera")[0]

signal reset
signal start

var mouse_pos = Vector2()
var real_mouse_pos = Vector2(275, 165)
var catched_fishes = []

var fish_amount = 1000

func _ready():
	set_process_input(true)
	pass

func hit_fish(fish):
	var unique = true
	for catched in catched_fishes:
		if catched.name == fish.name:
			unique = false
			break
	
	if unique:
		var new_fish = fish.duplicate()
		new_fish.catched = true
		catched_fishes.append(new_fish)
		print("catched a " + new_fish.name + " for the first time")
	
	cam.screenshake()
	emit_signal("reset")
	
func start():
	emit_signal("start")

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		real_mouse_pos = event.pos