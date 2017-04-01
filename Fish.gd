extends Area2D

export(Vector2) var common_depth = Vector2(0, 1000)
export(float) var speed = 25
export var name = "Fish"

onready var player = get_node("../Player")

var depth = 0

func _ready():
	set_process(true)

func _process(delta):
	var forward = get_transform().basis_xform(Vector2(0, -1))
	set_pos(get_pos() + forward * delta * speed)
	
	var diff = abs(player.depth - depth)
	diff /= 3
	if diff < 1:
		set_opacity(1 - diff)
<<<<<<< HEAD
=======
		show()
	else:
		hide()
>>>>>>> 115afb121f05ef96d258ee3aa70ba6e59d5002e0
	
	if get_pos().distance_to(Vector2(210, 210)) > 450:
		queue_free()





