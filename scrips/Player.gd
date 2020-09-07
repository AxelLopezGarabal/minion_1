extends Area2D

signal hit
export var consumed = 0
export var speed = 0.9
var isDashing = false
export var isAlive = true

func _ready():
	$CollisionShape2D.disabled = false
	pass

func _process(delta):
	look_at(get_viewport().get_mouse_position())
	follow(delta)
	readInput()

func readInput():
	if Input.is_action_pressed("ui_accept"):
		dash()

func follow(delta):
	position.x += (get_viewport().get_mouse_position().x - position.x) * speed * delta
	position.y += (get_viewport().get_mouse_position().y - position.y) * speed * delta

func dash():
	if !isDashing:
		change_dashing()
		speed_up()
		dash_end()
		cooldown()

func dash_end():
	yield(get_tree().create_timer(0.4), "timeout")
	speed_down()

func cooldown():
	yield(get_tree().create_timer(2.0), "timeout")
	change_dashing()

func change_dashing():
	isDashing = !isDashing

func speed_up():
	speed +=  2.7

func speed_down():
	speed -= 2.7

func _on_Player_body_entered(body):
	#if body.is_in_group("arrow")
	body.consume()
	consumed += 1

func _on_Player_area_entered(_area):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	#revive()
	isAlive = !isAlive
	
	
func revive():
	isAlive = !isAlive
	position = Vector2(500, 300)
	consumed = 0
	show()
	$CollisionShape2D.set_deferred("disabled", false)
