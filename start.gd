extends Node2D

onready var player = get_node("../../Player")
onready var book = get_node("../Book")

var size = 0.7

func _ready():
	set_process(true)
	set_scale(Vector2(.2, .2))
	game_manager.connect("reset", self, "reset")

func _process(delta):
	if (game_manager.mouse_pos - get_global_pos()).length() < 50 * size && book.height > 210:
		size = clamp(size + delta/3, 0.7, 1.4)
		set_scale(Vector2(size, size))
	else:
		size = clamp(size - delta/2, 0.7, 1.4)
		set_scale(Vector2(size, size))
	
	if size == 1.4:
		size = 0.7
		hide()
		game_manager.start()

func reset():
	set_scale(Vector2(size, size))
	show()



