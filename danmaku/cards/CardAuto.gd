extends Node

class Card:
	var name
	var image
	var desc
	
	func _init(name, imagePath, desc):
		self.name = name
		self.image = load(imagePath)
		self.desc = desc
	
export(Array, Resource) var cardsDeck = [
	Card.new("Bomb", "res://danmaku/cards/attackCard_bomb.png", "Throws a projectile which explodes when in contact with enemy"),
	Card.new("Shield", "res://danmaku/cards/defenseCard_shield.png", "Makes you invincible for a limited time"),
	Card.new("Healing Kit", "res://danmaku/cards/supportCard_healingKit.png", "Revives you one time")	
]

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
