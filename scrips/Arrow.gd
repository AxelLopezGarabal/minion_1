extends Area2D

var direction = Vector2()
export var speed = 100
var lifeSpan

func _ready():
	lifeSpan = 3
	pass

func _process(delta):
	position += speed * delta * direction
	if lifeSpan <= 0:
		queue_free()
		lifeSpan = 3
	lifeSpan -= delta

func shoot(aim_pos, gun_pos):
	global_position = gun_pos
	direction = (aim_pos - gun_pos)
	direction = direction.normalized()
	rotation = direction.angle()
	

func updateDirection(positionParam):
	shoot(positionParam, position)
