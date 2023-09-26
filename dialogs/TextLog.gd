extends Control


onready var items = $MarginContainer/ScrollContainer/VBoxContainer.get_children()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_log_update(tlog):
	for x in items:
		items[x].nameText = tlog[x].
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
