extends Control

onready var SelectedItem = 1;
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

onready var cursor = get_node("Cursor")
onready var cursorLabel = get_node("Cursor/MarginContainer/Label")
onready var ItemsContainer = get_node("PanelContainer/CanvasLayer/VBoxContainer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

#	if cursor.rect_position.y < 12 :
#		SelectedItem = 0
#		cursor.rect_position.y = 12
#	if cursor.rect_position.y > 12 + 82 * ItemsContainer.get_child_count() :
#		SelectedItem = ItemsContainer.get_child_count()
#		cursor.rect_position.y = 12 + 82 * ItemsContainer.get_child_count()
	
	if counter != 0:
		print(counter, "  ",  cursor.rect_position.y, " ", SelectedItem)
		if counter > 0:
			counter -= animSpeed
			cursor.rect_position.y -= animSpeed
		if counter < 0:
			counter += animSpeed
			cursor.rect_position.y += animSpeed
	if counter == 0:
		isCursorAnims = false
	
	if Input.is_action_just_pressed("ui_left"):
		pass
	if Input.is_action_just_pressed("ui_right"):
		pass
	if Input.is_action_just_pressed("ui_up"):
		if SelectedItem != 0 && !isCursorAnims:
			SelectedItem -= 1
			isCursorAnims = true
			counter = 80
			cursorLabel.text = Items[SelectedItem]
	if Input.is_action_just_pressed("ui_down"):
		if SelectedItem != ItemsContainer.get_child_count() - 1 && !isCursorAnims:
			cursorLabel.text = Items[SelectedItem]
			SelectedItem += 1
			isCursorAnims = true
			counter = -80
			cursorLabel.text = Items[SelectedItem]
