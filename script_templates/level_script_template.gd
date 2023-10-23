extends AnimationPlayer

export (Resource) var levelAnim # loading animation in the same folder as script is

func _ready():
	var err = add_animation("level", levelAnim) # add this animation to LevelPlayer node
	if err != null:
		print("ERROR While adding animation to LevelPlayer: ", err)

func action1(): # the actions that are called when LevelPlayer needs it in it's animation sequence
	pass
