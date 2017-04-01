extends Node2D

var depth = 0

func _ready():
	set_process(true)
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		set_pos(event.pos)

func _process(delta):
	depth += delta