extends Node

export (Array, Resource) var lines

func CreateBullets(line: BulletLine):
	print("creating bullets!")
	var bullet = BulletNode.new()

	bullet.curve2d = line.curve
	bullet.set_script(load("res://danmaku/bullets/Bullet.gd"))
	bullet.bullet_image = line.sprite
	bullet.BulletParams = line.BulletParams
	bullet.Scale = 2.0
	bullet.AnimSlowness = 8
	
	add_child(bullet)

func LogSomething(s: String):
	print("log")
	print(s)

func _ready():
	get_parent().play("LevelAnim")
