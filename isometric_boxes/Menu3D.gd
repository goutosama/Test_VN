extends Control

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
	if Input.is_action_just_pressed("Fire") && $InteractPopup.visible:
		$InteractPopup.visible = false
		var dialogueWindow = preload("res://dialogs/dialogWindow.tscn").instance()
		dialogueWindow.InkFile = load("res://ink_scripts/items.ink.json")
		dialogueWindow.StartingKnot = "wardrobe"
		dialogueWindow.useTextLog = false
		add_child(dialogueWindow)


func _on_Spatial_hideInteract():
	print("ui hook")
	$InteractPopup.visible = false
	pass # Replace with function body.


func _on_Spatial_showInteract():
	print("ui hook")
	$InteractPopup.visible = true
	pass # Replace with function body.
