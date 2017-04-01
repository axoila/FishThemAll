extends Sprite

export(String, DIR) var water_directory

onready var player = get_node("../Player")

var dir

var images = []

func _ready():
	set_process(true)
	
	dir = Directory.new()
	dir.open(water_directory)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		images.append(load(water_directory + "/" + file_name))
		file_name = dir.get_next()
	print(images.size())

func _process(delta):
	update()

func _draw():
	var index = floor(player.depth / 3) + 1
	print(index)
	draw_texture(images[index], Vector2())