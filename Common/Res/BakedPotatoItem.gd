extends Item

func _init(id):
	texture = load("res://Assets/Textures/Mystery_Seeds.png")
	
	item_id = id
	
	item_name = "Baked Potato"
	
	plantable = true
	
	cookable = false
