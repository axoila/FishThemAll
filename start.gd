extends Sprite

onready var player = get_node("../../Player")

var size = 0.2

func _ready():
	set_process(true)
	set_scale(Vector2(.2, .2))
	game_manager.connect("reset", self, "reset")

func _process(delta):
	if (game_manager.mouse_pos - get_global_pos()).length() < 50 * size:
		size = clamp(size + delta/5, 0.2, 1)
		set_scale(Vector2(size, size))
	else:
		size = clamp(size - delta/2, 0.2, 1)
		set_scale(Vector2(size, size))
	
	if size == 1:
		size = 0.2
		hide()
		game_manager.start()

func reset():
	set_scale(Vector2(size, size))
	show()



