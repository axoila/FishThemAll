extends Sprite

export(String, DIR) var water_directory

onready var player = get_node("../Player")

var dir

var images = []

func _ready():
	set_process(true)
	for i in range(21):
		if i < 9:
			images.append(load("%s/0%s.png" % [water_directory,i+1]))
		else:
			images.append(load("%s/%s.png" % [water_directory,i+1]))
			
	print(images.size())

func _process(delta):
	update()

func _draw():
	var index = clamp(floor(player.depth / 3), 0, 19)
	var ratio = (player.depth - index*3) / 3
	
	draw_texture(images[index], Vector2())
	draw_texture(images[index + 1], Vector2(), \
		Color(1, 1, 1, pingpong(ratio)))

func pingpong(tmp):
	tmp = fmod(tmp, 1)
	if fmod(tmp,2)>1:
		tmp = 1-tmp
	return tmp