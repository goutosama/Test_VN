extends Node2D

export (Script) var LevelScript

export var game_field_bullets = [716,760, 0, 0]
export var game_field_player = [730,678, 58, 50]

func _ready():
	$LevelPlayer.set_script(LevelScript)
	for bullet in $LevelPlayer/Bullets.get_children():
		bullet.game_field = game_field_bullets
	$Player.game_field = game_field_player
	pass

func bulletNodeInit():
	for bullet in $Bullets.get_children():
		bullet.game_field = game_field_bullets
