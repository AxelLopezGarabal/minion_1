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
		new_arrow.shoot(target, global_position)
		max_delay = random.randi_range(3, 4)
		fire_delay = max_delay
	else:
		fire_delay -= 1 * delta

func targetPlayer(player):
	target = player.position
	for arrow in $Container.get_children():
		arrow.updateDirection(player.position)

func die():
	for child in $Container.get_children():
		child.queue_free()
	flag = false
