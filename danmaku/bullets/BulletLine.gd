extends Resource
class_name BulletLine
export(Curve2D) var curve
export(Array, Resource) var BulletParams
export(Vector2) var position
export(Texture) var sprite

func _init(p_curve = null, p_params = [], p_position = Vector2(0,0), p_sprite = null):
	curve = p_curve
	BulletParams = p_params
	position = p_position
	sprite = p_sprite

func getSpeed():
	return BulletParams.speed

