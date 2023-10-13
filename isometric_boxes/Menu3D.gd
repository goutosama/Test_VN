extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuPopup/Menu/VerticalSlider/CanvasLayer.visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("special_q"):
		if !$MenuPopup.visible:
			$MenuPopup/Menu/VerticalSlider/CanvasLayer.visible = true
			$MenuPopup.visible = true
		else:
			$MenuPopup/Menu/VerticalSlider/CanvasLayer.visible = false
			$MenuPopup.visible = false
	if Input.is_action_just_pressed("Fire"):
		var dialogueWindow = preload("res://dialogs/dialogWindow.tscn").instance()
		dialogueWindow.InkFile = load("res://ink_scripts/items.ink.json")
		dialogueWindow.StartingKnot = "wardrobe"
		add_child(dialogueWindow)
