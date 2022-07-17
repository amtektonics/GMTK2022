extends Item

class_name PotatoItem

func _init(id):
	texture = load("res://Assets/Textures/Potato.png")
	item_id = id
	item_name = "Potato"
	plantable = true
	cookable = true
