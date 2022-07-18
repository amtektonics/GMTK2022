extends Item

class_name BakedPotatoItem

func _init(id):
	texture = load("res://Assets/Textures/BakedPotato.png")
	
	item_id = id
	
	item_name = "Baked Potato"
	
	plantable = true
	
	cookable = false
	
	food_amount = 10
