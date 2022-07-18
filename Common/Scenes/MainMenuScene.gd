extends Node

onready var scene_handler = get_parent()


func _on_PlayButton_pressed():
	scene_handler.load_game_play()


func _on_ExitButton_pressed():
	get_tree().quit()



func _on_Button_pressed():
	$Control/CenterContainer/VBoxContainer2.visible =false


func _on_HowToPlay_pressed():
	$Control/CenterContainer/VBoxContainer2.visible = true
