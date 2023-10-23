extends Node

class Card:
	var name
	var image
	var imageHor
	var desc
	var actionFunc
	
	func _init(nameStr, imagePath, descStr, actionFuncStr):
		self.name = nameStr
		self.image = load("res://danmaku/cards/" + imagePath)
		self.imageHor = load("res://danmaku/cards/horizontal/" + imagePath)
		self.desc = descStr
		self.actionFunc = actionFuncStr
	
export(Array, Resource) var cardsDeck = [
	Card.new("Bomb", "attackCard_bomb.png", "Throws a projectile which explodes when in contact with enemy", "bomb"),
	Card.new("Shield", "defenseCard_shield.png", "Makes you invincible for a limited time", "shield"),
	Card.new("Healing Kit", "supportCard_healingKit.png", "Revives you one time", "revive")
]
