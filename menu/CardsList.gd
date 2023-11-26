extends ItemList

onready var deck = CardAuto.cardsDeck
onready var slideBar = get_child(0)

func _ready():
	for i in deck:
		add_item(i.name, i.image)
	add_item("test", load("res://menu/button_editCardDeck.png"))
	add_item("test", load("res://menu/button_editCardDeck.png"))

func hideSlideBar():
	slideBar.rect_scale.x = 0
	print(get_child(0).margin_left)

func showSlideBar():
	slideBar.rect_scale.x = 1
