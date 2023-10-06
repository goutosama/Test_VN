extends Resource
export(int) var speed
export(int) var delay
export(float) var directionSine

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_speed = 0, p_delay = 0, p_dirsine = 1):
	speed = p_speed
	delay = p_delay
	directionSine = p_dirsine

