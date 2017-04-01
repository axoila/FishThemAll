extends Node

export(PackedScene) var pool
export(float) var fish_delay = 1

onready var player = get_node("../Player")

var instanced_pool
var timer = 0

func _ready():
	set_process(true)
	randomize()
	instanced_pool = pool.instance()

func _process(delta):
	timer += delta
	if timer > fish_delay:
		var new_fish = instanced_pool.get_fish(player.depth)
		new_fish.depth = player.depth + rand_range(0, 40)
		var angle = rand_range(0, 2*PI)
		var offset = Vector2(cos(angle), -sin(angle)) * 420
		new_fish.set_rot(angle + PI/2 + rand_range(-PI/4, PI/4))
		new_fish.set_pos(Vector2(210, 210) + offset)
		get_parent().add_child(new_fish)
		
		
		
		timer = 0