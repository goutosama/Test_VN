# warning-ignore-all:return_value_discarded

extends Control

# ############################################################################ #
# Imports
# ############################################################################ #

var InkPlayer = load("res://addons/inkgd/ink_player.gd")

# ############################################################################ #
# Public Nodes
# ############################################################################ #

# Alternatively, it could also be retrieved from the tree.
# onready var _ink_player = $InkPlayer
onready var _ink_player = $InkPlayer

# ############################################################################ #
# Lifecycle
# ############################################################################ #
onready var charName = get_node("DialogueWindow/textWindow/M/HBox/VBox/M2/Pc/Center/Label").text
onready var charNameBox = get_node("DialogueWindow/textWindow/M/HBox/VBox/M2/Pc")
onready var textBox = get_node("DialogueWindow/textWindow/M/HBox/VBox/M/Pc/RichTextLabel")
onready var choiceWindow = get_node("ChoiceWindow")

onready var textArray = []

class TextLine:
	var name
	var text

func _ready():	
	_ink_player.connect("loaded", self, "_story_loaded")

	# Creates the story. 'loaded' will be emitted once Ink is ready
	# continue the story.
	_ink_player.create_story()


# ############################################################################ #
# Signal Receivers
# ############################################################################ #

func _story_loaded(successfully: bool):
	if !successfully:
		return
	# _bind_externals()



# ############################################################################ #
# Private Methods
# ############################################################################ #

func _continue_story():
	if _ink_player.can_continue:
		var newLine = TextLine.new()
		newLine.text = _ink_player.continue_story()
		newLine.name = _ink_player.get_variable("name")
		charName = newLine.name
		textBox.text = newLine.text
		charNameBox.checkName()
		textArray.append(newLine)
		if textArray.size() > 4:
			textArray.pop_front()
		return
		# This text is a line of text from the ink story.
		# Set the text of a Label to this value to display it in your game.
	if _ink_player.has_choices:
		choiceWindow.runGetUpAnimation()
		choiceWindow.button1.text = _ink_player.current_choices[0]
		choiceWindow.button2.text = _ink_player.current_choices[1]
		choiceWindow.button3.text = _ink_player.current_choices[2]
	else: 
		if !(_ink_player.can_continue):
			theEnd()
		# 'current_choices' contains a list of the choices, as strings.
		# '_select_choice' is a function that will take the index of
		# your selection and continue the story.
		#_select_choice(0)

func theEnd():
	#the end is calling
	print("The End")
	pass

func _select_choice(index):
	_ink_player.choose_choice_index(index)
	_continue_story()
	_continue_story()
	choiceWindow.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_select"):
		_continue_story()
	if Input.is_action_just_pressed("ui_page_down"):
		if $PopupPanel.visible == false:
			$PopupPanel.popup()
		else:
			$PopupPanel.visible = false

# Uncomment to bind an external function.
#
# func _bind_externals():
# 	_ink_player.bind_external_function("<function_name>", self, "_external_function")
#
#
# func _external_function(arg1, arg2):
# 	pass


# Uncomment to observe the variables from your ink story.
# You can observe multiple variables by putting adding them in the array.
# func _observe_variables():
# 	_ink_player.observe_variables(["var1", "var2"], self, "_variable_changed")
#
#
# func _variable_changed(variable_name, new_value):
# 	print("Variable '%s' changed to: %s" %[variable_name, new_value])
