extends Resource
class_name BulletParameters
export(int) var speed
export(int) var delay
export(float) var directionRadians

func _init(p_speed = 0, p_delay = 0, p_dirrad = 1):
	speed = p_speed
	delay = p_delay
	directionRadians = p_dirrad

