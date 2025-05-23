extends Control


onready var items = get_node("MarginContainer/ScrollContainer/VBoxContainer").get_children()

func on_log_update(tlog):
	print("Log:")
	print(tlog[0].text)
	
	for n in items.size():
		items[n].hideEmpty()
	for n in tlog.size():
		items[items.size() - n -1].nameNode.text = tlog[n].name
		items[items.size() - n -1].namePC.hideEmpty()
		items[items.size() - n-1].textNode.text = tlog[n].text
		items[items.size() - n-1].hideEmpty()
	print(items[items.size() - 1].nameNode.text)

func _on_TextLog_visibility_changed():
	if visible:
		$AnimationPlayer.play("DiamondIn")
