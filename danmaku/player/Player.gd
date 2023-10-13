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
	
	position += velocity * speed

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position.x = clamp(position.x, game_field[2] - 16, game_field[0] + 16)
	position.y = clamp(position.y, game_field[3] - 16, game_field[1] + 16)

func _on_Player_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	print("dead")
	pass # Replace with function body.

func _on_Player_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	pass # Replace with function body.
