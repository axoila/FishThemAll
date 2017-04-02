extends Node2D

export(float) var speed

var depth = 0
var falling = false

func _ready():
	set_process(true)
	set_process_input(true)
	
	game_manager.connect("start", self, "set", ["falling", true])
	game_manager.connect("reset", self, "reset")

func _process(delta):
	var difference = game_manager.real_mouse_pos - get_pos()
	if difference.length() < delta * speed:
		set_pos(game_manager.real_mouse_pos)
	else:
		difference = difference.normalized() * delta * speed
		set_pos(get_pos() + difference)
	game_manager.mouse_pos = get_pos()
	
	if falling:
		depth += delta

func reset():
	depth = 0
	falling = false


