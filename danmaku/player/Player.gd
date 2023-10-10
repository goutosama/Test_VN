extends Area2D


export var speed = 7 # How fast the player will move (pixels/sec).
export var game_field = [800,500, 180, 180] # Size of the game window.

onready var state_machine = $AnimationTree.get("parameters/playback")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#var current_state = state_machine.get_current_node()
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
		$AnimatedSprite.flip_h = true

	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
		$AnimatedSprite.flip_h = false

	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
		
	if Input.is_action_just_pressed("ui_right"):
		state_machine.travel("ReimuTiltIdle")
	else:
		if Input.is_action_just_pressed("ui_left"):
			state_machine.travel("ReimuTiltIdle")

	if velocity.x == 0:
		state_machine.travel("ReimuIdle")

	position += velocity * speed
	position.x = clamp(position.x, game_field[2], game_field[0])
	position.y = clamp(position.y, game_field[3], game_field[1])
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func _on_Player_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("тебе пиздец")
	pass # Replace with function body.

func _on_Player_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
