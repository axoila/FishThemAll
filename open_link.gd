extends RichTextLabel

func _ready():
	connect("meta_clicked", self, "meta")
	pass

func meta(meta):
	print("open" + meta)
	OS.shell_open(meta)