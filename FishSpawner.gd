extends Node

export(PackedScene) var pool
export(float) var fish_delay = 1
export(NodePath) var progress

onready var player = get_node("../Player")

onready var instanced_pool = pool.instance()
var timer = 0

func _ready():
	set_process(true)
	randomize()
	
	game_manager.fish_amount = instanced_pool.get_child_count()
	get_node(progress).set_max(game_manager.fish_amount)
	print(str(game_manager.fish_amount, " fishes in the sea"))
	

func _process(delta):
	timer += delta
	if timer > fish_delay:
		spawn_fish()
		timer = 0

func spawn_fish():
	var depth = player.depth + rand_range(0, 50)
	var new_fish = instanced_pool.get_fish(depth)
	if new_fish == null:
		return
	new_fish.depth = depth
	var angle = rand_range(0, 2*PI)
	var offset = Vector2(cos(angle), -sin(angle)) * rand_range(\
	420 - (depth-player.depth) * 5 , 420)
	new_fish.set_rot(angle + PI/2 + rand_range(-PI/4, PI/4))
	new_fish.set_pos(Vector2(210, 210) + offset)
	get_parent().add_child(new_fish)
	new_fish._process(0)