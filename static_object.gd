extends Node2D

export(float) var depth = 0

onready var player = get_node("../Player")

func _ready():
	set_process(true)

func _process(delta):
	var diff = abs(player.depth - depth)
	diff /= 3
	if diff < 1:
		set_opacity(1 - diff)
