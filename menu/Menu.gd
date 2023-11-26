extends Control

onready var SelectedItem = 0;
onready var Items : Array = [
	"Continue",
	"Quest List",
	"Edit Card Deck", 
	"Save / Load",
	"Quit Game"
]


onready var counter : int = 0;
onready var animSpeed : int = 80/5;
onready var isCursorAnims : bool = false
onready var isSelectAnim : bool = false
onready var isSelected : bool = false

onready var Cursor = get_node("Cursor")
onready var CursorLabel = get_node("Cursor/MarginContainer/Label")
onready var ItemsContainer = get_node("VerticalSlider/CanvasLayer/VBoxContainer")
onready var Vslider = get_node("VerticalSlider")
onready var InfoPanel = get_node("MarginContainer/PanelContainer")

signal CurrItem(index)

# Called when the node enters the scene tree for the first time.
func _ready():
	CursorLabel.text = Items[SelectedItem]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# animation for cursor change
	if counter != 0:
		if isSelectAnim:
			if counter > 0:
				counter -= animSpeed
				Cursor.rect_position.y -= animSpeed
				Vslider.rect_position.y -= animSpeed
				ItemsContainer.rect_position.y -= animSpeed
				if counter == animSpeed:
					InfoPanel.visible = true
					$AnimationPlayer.play("ShowInfo")
			if counter < 0:
				counter += animSpeed
				Cursor.rect_position.y += animSpeed
				Vslider.rect_position.y += animSpeed
				ItemsContainer.rect_position.y += animSpeed

		else:
			if counter > 0:
				counter -= animSpeed
				Cursor.rect_position.y -= animSpeed
			if counter < 0:
				counter += animSpeed
				Cursor.rect_position.y += animSpeed

	if counter == 0:
		isCursorAnims = false
		isSelectAnim = false
	
	if Input.is_action_just_pressed("ui_left"):
		if !isCursorAnims && isSelected && SelectedItem != 0:
			isCursorAnims = true
			isSelectAnim = true
			isSelected = false
			$AnimationPlayer.play("HideInfo")
			
	if Input.is_action_just_pressed("ui_right"):
		emit_signal("CurrItem", SelectedItem)
		if !isCursorAnims && !isSelected:
			isCursorAnims = true
			isSelectAnim = true
			isSelected = true
			counter = 80 * SelectedItem
	if Input.is_action_just_pressed("ui_up"):
		if SelectedItem != 0 && !isCursorAnims && !isSelected:
			SelectedItem -= 1
			isCursorAnims = true
			counter = 80
			CursorLabel.text = Items[SelectedItem]
	if Input.is_action_just_pressed("ui_down"):
		if SelectedItem != ItemsContainer.get_child_count() - 1 && !isCursorAnims && !isSelected:
			SelectedItem += 1
			isCursorAnims = true
			counter = -80
			CursorLabel.text = Items[SelectedItem]


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "HideInfo":
		isCursorAnims = true
		isSelectAnim = true
		isSelected = false
		counter = -80 * SelectedItem
