extends Spatial


#onready var room = $StaticBody/sayGEXroom/Cube
#onready var camera = $Camera

signal showInteract
signal hideInteract

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_hideInteract():
	print("scene hook")
	emit_signal("hideInteract")
	pass # Replace with function body.


func _on_Player_showInteract():
	print("scene hook")
	emit_signal("showInteract")
	pass # Replace with function body.
