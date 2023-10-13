extends Node2D


onready var Player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if Input.is_action_just_pressed("AttackCard"):
		#bomb_throw()
		pass
	if Input.is_action_pressed("DefenceCard"):
		draw_circle(Player.position, 32, Color.white)
	if Input.is_action_just_pressed("SupportCard"):
		print("revived")
