extends StaticBody2D

var lifeSpan = 5

func _ready():
	pass # Replace with function body.

func consume():
	queue_free()
