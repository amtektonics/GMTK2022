extends Interactable

var hunger = 100

func _ready():
	._ready()
	$AnimationPlayer.play("Idle")


func clicked():
	if(GamePlayScene.get_mouse_item() != null):
		if(GamePlayScene.get_mouse_item().edible):
			hunger += GamePlayScene.get_mouse_item().food_amount
			GamePlayScene.guest_hunger.value = hunger
			GamePlayScene.remove_mouse_item_amount(1)


func minute_tick():
	hunger -= 0.2
	GamePlayScene.guest_hunger.value = hunger
