extends Interactable

onready var game_scene = get_node("/root/SceneHandler/GamePlayScene")

func clicked():
	if(game_scene.get_mouse_item() != null):
		if(game_scene.get_mouse_item().cookable):
			pass
