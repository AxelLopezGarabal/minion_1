extends Node2D

var fire_delay
var random = RandomNumberGenerator.new()
var max_delay = 3
var flag
var target

const Arrow = preload("res://Arrow.tscn")

func _ready():
	random.randomize()
	max_delay = random.randi_range(4, 5)
	flag = true
	fire_delay = max_delay
	
func _process(delta):
	if fire_delay < 0 and flag:
		var new_arrow = Arrow.instance()
		$Container.add_child(new_arrow)
		new_arrow.shoot(target, global_position, delta)
		max_delay = random.randi_range(3, 4)
		fire_delay = max_delay
	else:
		fire_delay -= 1 * delta

func targetPlayer(player, delta):
	target = player.position
	for arrow in $Container.get_children():
		arrow.updateDirection(player.position, delta)

func die():
	for child in $Container.get_children():
		child.queue_free()
	flag = false

func some_postion():
	return Vector2(some_x_value(), some_y_value())

func some_x_value():
	randomize()
	return rand_range(50, get_max_x_value())

func some_y_value():
	randomize()
	return rand_range(50, get_max_y_value())

func get_max_x_value():
	return get_viewport().get_visible_rect().size.x - position.x

func get_max_y_value():
	return get_viewport().get_visible_rect().size.y - position.y
