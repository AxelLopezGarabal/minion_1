extends Area2D

var direction = Vector2()
export var speed = 100
export var lifeSpanValue = 7
var lifeSpan

func _ready():
	lifeSpan = lifeSpanValue
	pass

func _process(delta):
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
		shoot(positionParam, position, delta)
