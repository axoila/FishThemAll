extends Area2D

export(Vector2) var common_depth = Vector2(0, 1000)
export(float) var speed = 25
export var name = "Fish"
export(String, MULTILINE) var description
export(float) var captive_scale = 1
export(String, FILE) var image

onready var player = get_tree().get_nodes_in_group("Player")[0]

var catched = false #flag that's set so the fish can't kill itself in captivity

var depth = 0

func _ready():
	set_process(true)

func _process(delta):
	var diff = abs(player.depth - depth)
	if diff/3 < 1:
		set_opacity(1 - diff/3)
		show()
	else:
		hide()
	
	if catched:
		depth = 0
		set_scale(Vector2(captive_scale, captive_scale))
		return #captive fishes can't move, kill or die
	
	var forward = get_transform().basis_xform(Vector2(0, -1))
	set_pos(get_pos() + forward * delta * speed)
	
	if diff < 2 && player.falling && overlaps_area(player):
		game_manager.hit_fish(self)
		
	
	if get_pos().distance_to(Vector2(210, 210)) > 450 || \
			depth < player.depth - 5:
		queue_free()





