extends Node2D

const voidScene = preload("res://Spawner_Void.tscn")
const DiamondScene = preload("res://Spawner_dimond.tscn")
const GameOver = preload("res://Button.tscn")

var player
export var points = 0
export var needed_amount = 7
var voidContainer
var diamondContainer
var random = RandomNumberGenerator.new()
var gameOver
var isAlive

func _ready():
	player = get_node("Player")
	isAlive = player.isAlive
	
	voidContainer = voidScene.instance()
	diamondContainer = DiamondScene.instance()
	gameOver = GameOver.instance()
	
	add_child(voidContainer)
	add_child(diamondContainer)
	add_child(gameOver)
	
	gameOver.hide()

func _process(delta):
	isAlive = player.isAlive
	if isAlive:
		voidContainer.targetPlayer(player, delta)
		if not player.consumed == points:
			$score._update(player.consumed)
			points = player.consumed
		next_Level()
	if not isAlive:
		gameOver.show()
		$score.hide()
		voidContainer.killChildren()
		diamondContainer.killChildren()
		$AudioStreamPlayer2D.stop()

func next_Level():
	if points == needed_amount:
		random.randomize()
		needed_amount = needed_amount + random.randi_range(4, needed_amount)
		voidContainer.spawn()

func tryAgain():
	player.revive()
	$score.show()
	gameOver.hide()

	voidContainer = voidScene.instance()
	add_child(voidContainer)

	diamondContainer = DiamondScene.instance()
	add_child(diamondContainer)
	$AudioStreamPlayer2D.play()

func player_die():
	player.die()
