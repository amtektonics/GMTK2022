extends TextureRect

export var slot_id = 0

var _item = null

var _count = 1

signal slot_left_clicked

signal slot_right_clicked

func _ready():
	get_parent().get_parent().register_slot(self)

func update_slot(item, count):
	_item = item
	_count = count
	if(item != null):
		$Item.texture = _item.texture
		if(_item != null && _count > 1):
			$Count.text = str(count)
		else:
			$Count.text = ""
	else:
		$Item.texture = null
		$Count.text = ""

func remove_amount(amount):
	if(amount >= _count):
		$Item.texture = null
		$Count.text = ""
		_item = null
		_count = 0
	else:
		_count = _count - amount
		$Count.text = str(_count)
		

func add_amount(amount):
	_count += amount
	$Count.text = str(_count)

func get_contents():
	return _item

func get_amount():
	return _count

func _on_Slot_gui_input(event):
	if event is InputEventMouseButton:
		if(event.pressed && event.button_index == BUTTON_LEFT):
			emit_signal("slot_left_clicked", slot_id)
		elif(event.pressed && event.button_index == BUTTON_RIGHT):
			emit_signal("slot_right_clicked", slot_id)
