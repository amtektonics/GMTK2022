extends Item

class_name MysterySeedItem

func _init(id):
	texture = load("res://Assets/Textures/Mystery_Seeds.png")
	
	item_id = id
	
	item_name = "Mystery Seeds"
	
	plantable = true
	
	cookable = true
	
	cooked_id = 3
