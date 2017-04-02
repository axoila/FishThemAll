extends Node

func _ready():
	pass

func get_fish(depth):
	var depth_pool = []
	for child in get_children():
		if child.common_depth.x < depth && child.common_depth.y > depth:
			depth_pool.append(child)
	var index = floor(rand_range(0, depth_pool.size()))
	if depth_pool.size() > 0:	
		return depth_pool[index].duplicate()
	else:
		return null