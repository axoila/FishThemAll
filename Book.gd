extends Sprite

var height = 420
var page = 0
var flip_page = 0

onready var tween = get_node("Tween")
onready var content = get_node("seiteNormal/Label")

export(String, MULTILINE) var credits

func _ready():
	set_process(true)
	
	tween.connect("tween_complete", self, "hide_anim")
	get_node("Timer").connect("timeout", self, "load_page")

func _process(delta):
	if game_manager.mouse_pos.y < height:
		height = clamp(height + delta * 100, 70, 420)
	else:
		height = clamp(height - delta * 500, 70, 420)
		if game_manager.mouse_pos.x < 60 || game_manager.mouse_pos.x > 360:
			flip_page += delta
		else:
			flip_page = 0
		if flip_page > 1.2:
			flip_page = 0
			change_site(game_manager.mouse_pos.x - 210)
			
	set_pos(Vector2(0, height))

func change_site(direction):
	print(direction)
	if direction == 0:
		printerr("please input a valid direction")
		return
	
	if direction < 0:
		if page <= 0:
			return
		tween.interpolate_property(get_node("AnimatedSprite"), "frame", \
		6, 0, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		if page > game_manager.catched_fishes.size(): 
			return
		tween.interpolate_property(get_node("AnimatedSprite"), "frame", \
		0, 6, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	page += sign(direction)
	get_node("AnimatedSprite").show()
	tween.start()
	get_node("Timer").start()

func load_page():
	if page < 1:
		#first page
		get_node("seiteNormal").hide()
		return
	get_node("seiteNormal").show()
	if page > game_manager.catched_fishes.size():
		# last page
		content.set_bbcode(credits)
		return
	
	content.set_bbcode(game_manager.catched_fishes[page-1].description\
	+ ("\n[img]%s[/img]" % \
	game_manager.catched_fishes[page-1].image))
	

func hide_anim(foo, bar):
	get_node("AnimatedSprite").hide()