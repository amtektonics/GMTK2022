extends Interactable

export var spin_speed = 10

onready var _delay_timer = $DelayTimer

var wheel_1_spinning = false
var wheel_1_should_stop = false

var wheel_2_spinning = false
var wheel_2_should_stop = false

var wheel_1_value = 0
var wheel_2_value = 0

var wait_to_spin = true

var can_spin = true
var minute_counter = 0

func clicked():
	if(can_spin):
		if(wheel_1_spinning == false && wheel_2_spinning == false):
			$AnimationPlayer.play("ArmPull")
			$CoinOpAudio.play()
			wait_to_spin = true
			wheel_1_value = 0
			wheel_2_value = 0
			_delay_timer.start()
			can_spin = false
			mouse_over_text = "Wait until tomorrow"


func _process(delta):
	if(wheel_1_spinning):
		$Wheel1.rotate_x(spin_speed * delta)
		if(wheel_1_should_stop):
			var target = -((wheel_1_value * 60) - 60)
			$Wheel1.set_rotation_degrees(Vector3(target, 0, 0))
			wheel_1_spinning = false
	
	if(wheel_2_spinning):
		$Wheel2.rotate_x(spin_speed * delta)
		if(wheel_2_should_stop):
			var target2 = -((wheel_2_value * 60) - 60)
			$Wheel2.set_rotation_degrees(Vector3(target2, 0, 0))
			wheel_2_spinning = false
			handle_spin_result()

func minute_tick():
	minute_counter += 1
	if(minute_counter >= 144):
		can_spin = true
		minute_counter = 0
		mouse_over_text = "Spin"

func handle_spin_result():
	print(wheel_1_value)
	print(wheel_2_value)
	if(wheel_1_value == 6 && wheel_2_value == 6):
		$Jackpot.play()
		if(!GamePlayScene.get_node("Kitchen/Plant1").visible):
			GamePlayScene.get_node("Kitchen/Plant1").visible = true
			
		elif(!GamePlayScene.get_node("Kitchen/Plant2").visible):
			GamePlayScene.get_node("Kitchen/Plant2").visible = true
		else:
			GamePlayScene.hand_inventory.add_item(Globals.MYSTERY_SEED_ITEM, 6)
	elif(wheel_1_value == 1 && wheel_2_value == 1):
		$wawa.play()
		GamePlayScene.guest.hunger -= 5
	elif(wheel_1_value != wheel_2_value):
		$wawa.play()
	elif(wheel_1_value == wheel_2_value):
		if(wheel_1_value >= 4):
			GamePlayScene.hand_inventory.add_item(Globals.POTATO_ITEM, int(rand_range(2,4)))
		else:
			GamePlayScene.hand_inventory.add_item(Globals.MYSTERY_SEED_ITEM, int(rand_range(2,4)))
	
	wheel_1_value = 0
	wheel_2_value = 0

func lock_wheel_choice():
	var value = rand_range(1, 6)

func _on_DelayTimer_timeout():
	if(wait_to_spin):
		_delay_timer.start()
		wait_to_spin = false
		wheel_1_spinning = true
		wheel_2_spinning = true
		wheel_1_should_stop = false
		wheel_2_should_stop = false
	elif(!wheel_1_should_stop):
		wheel_1_should_stop = true
		wheel_1_value = int(rand_range(1, 6))
		_delay_timer.start()
	elif(!wheel_2_should_stop):
		wheel_2_should_stop = true
		wheel_2_value = int(rand_range(1, 6))
