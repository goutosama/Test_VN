extends PanelContainer

onready var nameNode = get_node("VBox/M2/Pc/Center/Label")
onready var namePC = get_node("VBox/M2/Pc")
onready var textNode = get_node("VBox/M/Pc/RichTextLabel")
# Called when the node enters the scene tree for the first time.
func _ready():
	nameNode.text = ""
	textNode.text = ""
	pass # Replace with function body.

func hideEmpty():
	if textNode.text == "":
		visible = false
	else:
		visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
