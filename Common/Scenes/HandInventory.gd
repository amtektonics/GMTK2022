extends Control

onready var game_scene = get_node("/root/SceneHandler/GamePlayScene")

var _slots = {}

var _selected = 1

func register_slot(slot):
	_slots[slot.slot_id] = slot
	slot.connect("slot_left_clicked", self, "_slot_left_clicked")
	slot.connect("slot_right_clicked", self, "_slot_right_clicked")


func get_selected():
	return _selected

func get_selected_slot():
	return _slots[_selected]

func clear_selected_slot():
	_slots[_selected].update_slot(null, 0)

func get_slot(id):
	return _slots[id]

func _slot_left_clicked(id):
	if(game_scene.get_mouse_item() == null):
		var item = _slots[id].get_contents()
		if(item != null):
			game_scene.set_mouse_item(item, 1)
			_slots[id].remove_amount(1)
	else:
		var item = _slots[id].get_contents()
		if(item == null):
			_slots[id].update_slot(game_scene.get_mouse_item(), game_scene.get_mouse_item_amount())
			game_scene.clear_mouse_item()
		else:
			if(game_scene.get_mouse_item().item_id == item.item_id):
				_slots[id].add_amount(game_scene.get_mouse_item_amount())
				game_scene.clear_mouse_item()

func _slot_right_clicked(id):
	pass

func add_item(item, amount):
	var found_slot = false
	if(amount > 0):
		for s in _slots:
			var i = _slots[s].get_contents()
			if(i != null):
				if(i.item_id == item.item_id):
					var current_amount = _slots[s].get_amount()
					var new_amount = current_amount + amount
					_slots[s].update_slot(item, new_amount)
					return
		
		if(!found_slot):
			for s in _slots:
				if(_slots[s].get_contents() == null):
					_slots[s].update_slot(item, amount)
					return
