extends Label

export var score = "Score:: "

func _ready():
	text = score + str(0)
	pass # Replace with function body.

func _update(points):
	text = score + str(points)

func _process(_delta):
	pass
