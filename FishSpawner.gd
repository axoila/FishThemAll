extends Node

export(PackedScene) var pool
export(float) var fish_delay = 1

onready var player = get_node("../Player")

var instanced_pool
var timer = 0

func _ready():
	set_process(true)
	
	instanced_pool = pool.instance()

func _process(delta):
	timer += delta
	if timer > fish_delay:
		var new_fish = instanced_pool.get_fish(player.depth)
		new_fish.depth = player + rand_range(0, 20)
		new_fish.set_pos(Vector2(210, 210))
		get_parent().add_child(new_fish)
		
		
		
		timer = 0
	get_node("../Label").set_text(str(timer))