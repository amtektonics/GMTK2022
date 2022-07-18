extends Interactable

onready var game_scene = get_node("/root/SceneHandler/GamePlayScene")

var _cooking_item = null
var _cooking_percent = 0

func clicked():
	if(_cooking_item == null):
		if(game_scene.get_mouse_item() != null):
			if(game_scene.get_mouse_item().cookable):
				_cooking_item = game_scene.get_mouse_item()
				game_scene.remove_mouse_item_amount(1)
	else:
		if(_cooking_percent >= 100):
			game_scene.set_mouse_item(Globals.Items[_cooking_item.cooked_id], 1)
			_cooking_item = null
			mouse_over_text = "Cook Food"
			_cooking_percent = 0

func minute_tick():
	if(_cooking_item != null):
		if(_cooking_percent < 100):
			_cooking_percent += 3
			mouse_over_text = _cooking_item.item_name + ": " + str(int(_cooking_percent)) + "%"
		else:
			mouse_over_text = "Take Food"
	else:
		mouse_over_text = "Cook Food"
