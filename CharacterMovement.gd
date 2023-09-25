extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var movementCircle = [0, 0, 0, 0]
# behaves like this
#	  ↑0   
#  ←3    1→
#	  ↓2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ProcessInputs()
	Move()
	 
	pass

func Move(speed):
	
	pass

func ProcessInputs():
	if Input.is_action_pressed("ui_up"):
		movementCircle[0] = 1
	else:
		movementCircle[0] = 0
	if Input.is_action_pressed("ui_right"):
		movementCircle[1] = 1
	else:
		movementCircle[1] = 0
	if Input.is_action_pressed("ui_down"):
		movementCircle[2] = 1
	else:
		movementCircle[2] = 0
	if Input.is_action_pressed("ui_left"):
		movementCircle[3] = 1
	else:
		movementCircle[3] = 0
