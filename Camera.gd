extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func screenshake():
	var tween = get_node("Tween")
	var origin = get_offset()
	var rot = get_rot()
	var new_pos
	var new_rot
	for i in range(5):
		new_pos = Vector2(rand_range(-10, 10), rand_range(-10, 10))
		new_rot = rand_range(-PI/4, PI/4)
		tween.interpolate_property(self, "offset", origin, new_pos, \
		0.05, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, i * 0.05)
		tween.interpolate_property(self, "transform/rot", rot, new_rot, \
		0.05, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, i * 0.05)
		origin = new_pos
		rot = new_rot
	new_pos = Vector2()
	new_rot = 0
	tween.interpolate_property(self, "offset", origin, new_pos, \
	0.05, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 5 * 0.05)
	tween.interpolate_property(self, "transform/rot", rot, new_rot, \
	0.05, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 5 * 0.05)
	tween.start()




