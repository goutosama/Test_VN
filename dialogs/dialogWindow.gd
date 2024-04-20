# warning-ignore-all:return_value_discarded

extends Control

# ############################################################################ #
# Imports
# ############################################################################ #

var InkPlayer = load("res://addons/inkgd/ink_player.gd")

# ############################################################################ #
# Public Nodes
# ############################################################################ #
onready var _ink_player = $InkPlayer

export var InkFile : Resource


#export (int) var maxTextLogLine = 8
export (String) var StartingKnot = "None"

export (bool) var useTextLog = true

# ############################################################################ #
# Lifecycle
# ############################################################################ #
export var DialogueWindowPath : NodePath
onready var dialogueWindow = get_node(DialogueWindowPath)
onready var charNameBox = dialogueWindow.get_node(dialogueWindow.charNameBoxPath)
onready var textBox = dialogueWindow.get_node(dialogueWindow.textBoxPath)
onready var choiceWindow = get_node("Dialogue layer/ChoiceWindow")
onready var Illustration = get_node("Background image/Illustration")
onready var textLog = get_node("Popup layer/PopupPanel/TextLog")

onready var textArray = []
onready var choices = []
onready var illustrate = "None"

class TextLine:
	var name
	var text

func _ready():	
#	Illustration.visible = false
	_ink_player.ink_file = InkFile
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
	if StartingKnot != "None":
		_ink_player.choose_path(StartingKnot)
	_continue_story(false)

# ############################################################################ #
# Private Methods
# ############################################################################ #

func _continue_story(isChoice: bool):
	if _ink_player.can_continue:
		var newLine = TextLine.new()
		newLine.text = _ink_player.continue_story()
		newLine.name = _ink_player.get_variable("name")
		illustrate = _ink_player.get_variable("ill")
		textBox.text = newLine.text
		charNameBox.get_node("Center/Label").text = newLine.name
		charNameBox.hideEmpty()
		if isChoice:
			var choose = newLine.text
			newLine.text = ""
			for n in choices.size():
				if choices[n] + "\n" == choose:
					choices[n] = "You choose lol " + choose
					newLine.text += choices[n] + "\n"
				else:
					newLine.text += choices[n] + "\n \n"
			choices = []

# Do we need to store last lines in there?
#		textArray.append(newLine)
#		if textArray.size() > maxTextLogLine:
#			textArray.pop_front()
		textLog.on_log_update([newLine])
		#print(illustrate)
		
		# NEEDS TESTING
#		if illustrate == null:
#			illustrate = "None"
#		if illustrate != "None" || illustrate != "":
#			Illustration.visible = true
#			Illustration.texture = load("res://" + illustrate)
#		else:
#			Illustration.visible = false
		return
		
		# This text is a line of text from the ink story.
		# Set the text of a Label to this value to display it in your game.
		
	# Choice methods return a string "You choose [answer]" as another line which is actually not needed behaviour
	# Fix returning this thing and make an exclusive window inside text log if it's player's answer 				FIX!!!
	if _ink_player.has_choices:
		choiceWindow.runGetUpAnimation()
		choiceWindow.button1.text = _ink_player.current_choices[0]
		if _ink_player.current_choices.size() >= 2:
			choiceWindow.button2.text = _ink_player.current_choices[1]
		else:
			choiceWindow.button2.visible = false
		if _ink_player.current_choices.size() >= 3:
			choiceWindow.button3.text = _ink_player.current_choices[2]
		else:
			choiceWindow.button3.visible = false
		
		choices = _ink_player.current_choices
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
	_continue_story(true)
	_continue_story(false)
	choiceWindow.visible = false

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_select") && textLog.get_parent().visible == false:
			_continue_story(false)
		if Input.is_action_just_pressed("ui_down") && useTextLog:
			print("log", textLog.visible)
			if textLog.get_parent().visible == false:
				textLog.get_parent().popup()
			else:
				textLog.get_parent().visible = false

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
