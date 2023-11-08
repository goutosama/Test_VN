extends KinematicBody

export var speed = 1 # How fast the player will move (pixels/sec).

onready var spriteScale = 8

onready var camera = get_parent().get_parent().get_node("Camera Pivot")
onready var Menu = get_parent().get_parent().get_node("UI/MenuPopup" )
onready var Interact = get_parent().get_parent().get_node("UI/InteractPopup")

func _ready():
	$AnimatedSprite3D.scale = Vector3.ONE * spriteScale

func _physics_process(delta):
	if !Menu.visible:
		# we're dividing by 5 because player is waaay too fast (kinda like Sonic)
		var forward = camera.transform.basis.z.normalized() * speed * 0.2
		var velocity = Vector3.ZERO
		#var velocity = Vector3.ZERO # The player's movement vector.
		if Input.is_action_pressed("ui_right"):
			velocity = -forward.cross(Vector3.UP) / 1.5
			#velocity.z = -1
			$AnimatedSprite3D.flip_h = false
			$AnimatedSprite3D.set_animation("side")
			

		if Input.is_action_pressed("ui_left"):
			velocity = forward.cross(Vector3.UP) / 1.5

			$AnimatedSprite3D.flip_h = true
			$AnimatedSprite3D.set_animation("side")

		if Input.is_action_pressed("ui_down"):
			velocity = forward
			$AnimatedSprite3D.set_animation("front")

			
		if Input.is_action_pressed("ui_up"):
			velocity = -forward
			$AnimatedSprite3D.set_animation("back")
		
		
		move_and_collide(velocity)

var firstEnter = false
func _on_Interact_body_entered(body):
	print(body)
	if firstEnter:
		Interact.visible = true
	else: 
		firstEnter = true
	pass # Replace with function body.

func _on_Interact_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	Interact.visible = false
	pass # Replace with function body.
