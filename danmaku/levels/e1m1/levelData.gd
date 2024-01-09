extends AnimationPlayer

export (Array, Resource) var lines

func CreateBullets(line: BulletLine):
	var bullet = BulletNode.new()
	var path2d = Path2D.new()
	path2d.curve = line.curve
	bullet.set_script("res://danmaku/bullets/Bullet.gd")
	bullet.bullet_image = line.sprite
	bullet.path2dPath = path2d
	bullet.BulletParams = line.BulletParams
	bullet.scale = 2.0
	bullet.AnimSlowness = 8

func _ready():
	self.play("LevelAnim")
