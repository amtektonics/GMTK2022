extends Item

class_name BreadItem

func _init(id):
	texture = load("res://Assets/Textures/bread.png")
	
	item_id = id
	
	item_name = "Bread"
	
	plantable = false
	
	cookable = false
	
	edible = true
	
	food_amount = 5
