extends Sprite

onready var book = get_node("../../../Book")

func _ready():
	set_process(true)

func _process(delta):
	if (game_manager.mouse_pos - get_global_pos()).length() < 30:
#		print(get_global_pos())
		book.height -= delta * 400
		book.load_page()