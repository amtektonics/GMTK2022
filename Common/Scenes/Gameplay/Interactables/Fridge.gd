extends Interactable

onready var game_scene = get_node("/root/SceneHandler/GamePlayScene")

func clicked():
	game_scene.show_inventory()
