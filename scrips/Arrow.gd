extends Area2D

var direction = Vector2()
export var speed = 100
export var lifeSpanValue = 0
export(float) var friction = 0.9
var hasTarget = false
var lifeSpan
var somePosition

func _ready():
	lifeSpanValue = RandomNumberGenerator.new().randi_range(5, 8)
	lifeSpan = lifeSpanValue
	somePosition = some_postion()
	pass

func _process(delta):
	if not hasTarget and not position.distance_to(somePosition) < 50:
		shoot(somePosition, position, delta)
	if lifeSpan <= 0:
		queue_free()
		lifeSpan = lifeSpanValue
	lifeSpan -= delta

func shoot(aim_pos, gun_pos, delta):
	global_position = gun_pos
	direction = (aim_pos - gun_pos)
	direction = direction.normalized()
	rotation = direction.angle()
	
	position += speed * delta * direction

func updateDirection(positionParam, delta):
	if (position.distance_to(positionParam) < 250):
		hasTarget = true
		shoot(positionParam, position, delta)
	else:
		hasTarget = false

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
