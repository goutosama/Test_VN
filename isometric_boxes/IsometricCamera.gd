extends Spatial

export var scenePath: NodePath
onready var scene := get_node(scenePath) as Spatial 

export var roomPath: NodePath
onready var room := get_node(roomPath) as Spatial 

export (bool) var mouseEnabled = true
export (float) var mouseSensitivity = 0.3
export (bool) var isLocked = false


onready var yaw : float = 0.0
onready var rotateState : bool = false
onready var counter : int = 0
onready var rotationSpeed : int = 15

func _ready():
	if rotateState:
		room.get_node("Walls1").visible = false
		room.get_node("Walls2").visible = true
	else:
		room.get_node("Walls2").visible = false
		room.get_node("Walls1").visible = true
# this script no longer rotates the scene, it moves itself
func _input(event):
	if !isLocked:
		if event is InputEventMouseMotion and mouseEnabled:
			var mouseVec : Vector2 = event.get_relative()
			
			set_rotation(Vector3(0.0, deg2rad(yaw), 0.0))
			
			yaw = fmod(yaw  - mouseVec.x * mouseSensitivity , 360.0)
		#print(rotation)
		
		if !mouseEnabled:
			if Input.is_action_just_pressed("special_e"):
				print(rotateState)
				if counter == 0:
					counter = 180
					if rotateState:
						rotateState = false
					else:
						rotateState = true

func _physics_process(delta):
		if counter != 0:
			counter -= rotationSpeed
			#print(counter)
			rotation_degrees.y += rotationSpeed
			if counter == 90:
				if rotateState:
					room.get_node("Walls1").visible = false
					room.get_node("Walls2").visible = true
				else:
					room.get_node("Walls2").visible = false
					room.get_node("Walls1").visible = true

