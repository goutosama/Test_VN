extends Control

func _ready():
	$AnimationPlayer.play("InitMenu")
	pass


func _on_NewGame_pressed():
	get_tree().change_scene("res://isometric_boxes/box3d-cirno.tscn")
	pass # Replace with function body.


func _on_Settings_pressed():
	pass # Replace with function body.


func _on_QuitGame_pressed():
	get_tree().quit()
	pass # Replace with function body.
