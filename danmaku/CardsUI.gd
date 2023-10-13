extends MarginContainer

#onready var AttackCard = CardAuto.cardsDeck[0]
#onready var DefenceCard = CardAuto.cardsDeck[1]
#onready var SupportCard = CardAuto.cardsDeck[2]

onready var AttackCard = $VBoxContainer/TextureRect
onready var DefenceCard = $VBoxContainer/TextureRect2
onready var SupportCard = $VBoxContainer/TextureRect3

onready var curve = $Path2D

func _ready():
	#AttackCard.texture = CardAuto.cardsDeck[0].image
	#DefenceCard.texture =  CardAuto.cardsDeck[1].image
	#SupportCard.texture =  CardAuto.cardsDeck[2].image
	

	AttackCard.rect_position = $Path2D.curve.get_point_position(0)
	DefenceCard.rect_position = $Path2D.curve.get_point_position(1)
	SupportCard.rect_position = $Path2D.curve.get_point_position(2)
	AttackCard.set_rotation(PI/4)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
