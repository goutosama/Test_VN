extends Control

onready var healthBar = $"HP Bar"

func set_hpBar(health : int):
	healthBar.set_frame(health)
	pass
