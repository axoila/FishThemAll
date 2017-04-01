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
	var index = fmod(floor(player.depth / 3), 21)
	var ratio = fmod(player.depth, 3) / 3
	
	draw_texture(images[index], Vector2())
	draw_texture(images[index + 1], Vector2(), Color(1, 1, 1, ratio))