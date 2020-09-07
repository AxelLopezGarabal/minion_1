extends Node2D

const voidScene = preload("res://Spawner_Void.tscn")
const DiamondScene = preload("res://Spawner_dimond.tscn")
const GameOver = preload("res://Button.tscn")

var player
export var points = 0
var voidContainer
var diamondContainer
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

func _process(_delta):
	isAlive = player.isAlive
	if isAlive:
		voidContainer.targetPlayer(player)
		if not player.consumed == points:
			$score._update(player.consumed)
			points = player.consumed
	if not isAlive:
		gameOver.show()
		$score.hide()
		voidContainer.killChildren()
		diamondContainer.killChildren()

func tryAgain():
	player.revive()
	$score.show()
	gameOver.hide()

	voidContainer = voidScene.instance()
	add_child(voidContainer)

	diamondContainer = DiamondScene.instance()
	add_child(diamondContainer)
