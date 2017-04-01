extends Sprite

export var depths = FloatArray()
export var images = []

onready var player = get_node("../Player")

func _ready():
	set_process(true)

func _process(delta):
	update()

func _draw():
	var index = -1
	for i in range(depths.size()):
		if depths[i] > player.depth:
			index = i
			break
#	var texture1 = ImageTexture()
#	texture1.create_from_image(images[index])
#	draw_texture(texture1, Vector2())