extends ProgressBar

func _ready():
	game_manager.connect("reset", self, "update")
	set_value(0)

func update():
	set_value(game_manager.catched_fishes.size())