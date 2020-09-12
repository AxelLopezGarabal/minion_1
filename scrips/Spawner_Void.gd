extends Node2D

const void_element = preload("res://Void.tscn")

func _ready():
	spawnN(3)

func spawnN(n):
	var i = n
	while(i != 0):
		spawn()
		i -= 1

func spawn():
	var void_ = void_element.instance()
	void_.position = create_new_position()
	$Container.add_child(void_)

func create_new_position():
	 return Vector2(positionX(), positionY())

func positionX():
	return some_x_value()

func positionY():
	return some_y_value()

func some_x_value():
	randomize()
	return rand_range(50, get_max_x_value())

func some_y_value():
	randomize()
	return rand_range(50, get_max_y_value())

func get_max_x_value():
	return get_viewport().get_visible_rect().size.x - 50

func get_max_y_value():
	return get_viewport().get_visible_rect().size.y - 50

func targetPlayer(player, delta):
	for v in $Container.get_children():
		v.targetPlayer(player, delta)

func killChildren():
	for child in $Container.get_children():
		child.die()
		child.queue_free()
