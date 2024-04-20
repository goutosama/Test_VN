extends MarginContainer


onready var button1 = get_node("HBoxContainer/PanelContainer2/VBoxContainer/Button")
onready var button2 = get_node("HBoxContainer/PanelContainer2/VBoxContainer/Button2")
onready var button3 = get_node("HBoxContainer/PanelContainer2/VBoxContainer/Button3")
onready var window = get_parent().get_parent()

func _ready():
	visible = false
	pass # Replace with function body.

func runGetUpAnimation():
	visible = true
	pass #TODO: full animation

func ChoiceSelected():
	if button1.is_pressed():
		return 0
	if button2.is_pressed():
		return 1
	if button3.is_pressed():
		return 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var b = ChoiceSelected()
	if b != null:
		return window._select_choice(b)
	pass
