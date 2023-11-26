extends PanelContainer

func _ready():
	for i in get_children():
		i.visible = false

func _on_Item_Opened(index: int):
	match index:
		2:
			$CardsList.visible = true
