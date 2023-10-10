extends KinematicBody

export var speed = 14 # How fast the player will move (pixels/sec).


onready var cos45 : float = 0.70710678118

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
		velocity.z = 1
		
	if Input.is_action_pressed("ui_up"):
		velocity.z = -1

	velocity.x = velocity.x * cos45 - velocity.x * cos45
	velocity.z = velocity.x * cos45 + velocity.y * cos45
		
#	if Input.is_action_just_pressed("ui_right"):

#	else:
#		if Input.is_action_just_pressed("ui_left"):


#	if velocity.x == 0:
	print(velocity)
	move_and_slide(velocity * speed)
	#position += velocity * speed
	#position.x = clamp(position.x, game_field[2], game_field[0])
	#position.y = clamp(position.y, game_field[3], game_field[1])
	pass
