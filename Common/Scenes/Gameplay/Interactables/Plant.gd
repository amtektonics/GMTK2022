extends Interactable

var planted = false

var growth_percent = 0

var _growing_item = null

onready var game_scene = get_node("/root/SceneHandler/GamePlayScene")


func minute_tick():
	if(_growing_item != null):
		var rand_g = rand_range(-1, 2)
		growth_percent += 1 + rand_g
		if(growth_percent < 0):
			growth_percent = 0
		
		growth_percent = int(growth_percent)
		
		if(growth_percent >= 100):
			growth_percent = 100
		
		mouse_over_text = _growing_item.item_name + ": " + str(int(growth_percent)) + "%"
	

func clicked():
	if(planted):
		if(growth_percent >= 100):
			game_scene.hand_inventory.add_item(_growing_item, int(rand_range(1, 5)))
			set_growing_item(null)
	else:
		if(game_scene.get_mouse_item() != null):
			if(game_scene.get_mouse_item().plantable):
				var amount = game_scene.get_mouse_item_amount()
				set_growing_item(game_scene.get_mouse_item())
				_growing_item = game_scene.get_mouse_item()
				game_scene.remove_mouse_item_amount(1)
				planted = true
				mouse_over_text = _growing_item.item_name + ": " + str(growth_percent) + "%"

func set_growing_item(item):
	if(item != null):
		var mat = SpatialMaterial.new()
		mat.flags_transparent = true
		mat.albedo_texture = item.texture
		$GrowingItem.material = mat
		$GrowingItem.visible = true
		planted = true
	else:
		$GrowingItem.material = null
		$GrowingItem.visible = false
		planted = false

func mouse_enter():
	if(planted):
		if(growth_percent < 100):
			mouse_over_text = "Growth " + str(growth_percent) + "%"
		else:
			mouse_over_text = "Harvest"
	else:
		pass
