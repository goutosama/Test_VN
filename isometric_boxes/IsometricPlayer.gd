extends KinematicBody

export var speed = 7 # How fast the player will move (pixels/sec).

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	#var current_state = state_machine.get_current_node()
	var velocity = Vector3.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
		#$AnimatedSprite.flip_h = true

	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
		#$AnimatedSprite.flip_h = false

	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
		
#	if Input.is_action_just_pressed("ui_right"):

#	else:
#		if Input.is_action_just_pressed("ui_left"):


#	if velocity.x == 0:

	move_and_slide(velocity)
	#position += velocity * speed
	#position.x = clamp(position.x, game_field[2], game_field[0])
	#position.y = clamp(position.y, game_field[3], game_field[1])
	pass
