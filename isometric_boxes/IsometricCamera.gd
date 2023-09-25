extends Camera

export var scenePath: NodePath
onready var scene := get_node(scenePath) as Spatial 

export var roomPath: NodePath
onready var room := get_node(roomPath) as Spatial 

export (bool) var movEnabled = true
export (float) var mouseSensitivity = 0.3

onready var yaw : float = 0.0

	
func _input(event):
	if event is InputEventMouseMotion and movEnabled:
		var mouseVec : Vector2 = event.get_relative()
		
		scene.set_rotation(Vector3(0.0, deg2rad(yaw), 0.0))
		
		yaw = fmod(yaw  - mouseVec.x * mouseSensitivity , 360.0)
	print(scene.get_rotation().y)
	if scene.get_rotation().y > -2 && scene.get_rotation().y < 1 :
		room.get_node("Cube001").visible = false
		room.get_node("Cube002").visible = true
	else:
		room.get_node("Cube002").visible = false
		room.get_node("Cube001").visible = true
