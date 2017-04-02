extends Node2D

var depth = 0

var falling = false

func _ready():
	set_process(true)
	set_process_input(true)
	
	game_manager.connect("start", self, "set", ["falling", true])
	game_manager.connect("reset", self, "reset")

func _process(delta):
	set_pos(game_manager.mouse_pos)
	if falling:
		depth += delta

func reset():
	depth = 0
	falling = false


