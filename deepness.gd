extends Label

onready var player = get_node("../Player")

func _ready():
	set_process(true)

func _process(delta):
	set_text(str(floor(player.depth * 10)))