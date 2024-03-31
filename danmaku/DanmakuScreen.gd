extends Node2D

export (Script) var LevelScript

export var game_field_bullets = [716,760, 0, 0]
export var game_field_player = [730,678, 58, 50]
onready var game = get_node("Game Objects")

func _ready():
	game.get_node("LevelPlayer").set_script(LevelScript)
	for bullet in game.get_node("LevelPlayer/Bullets").get_children():
		bullet.game_field = game_field_bullets
	game.get_node("Player").game_field = game_field_player
	pass

func bulletNodeInit():
	for bullet in game.get_node("Bullets").get_children():
		bullet.game_field = game_field_bullets
