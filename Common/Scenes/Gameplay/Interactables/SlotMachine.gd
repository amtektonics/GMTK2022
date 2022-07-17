extends Interactable

export var spin_speed = 0.25

onready var _delay_timer = $DelayTimer

var wheel_1_spinning = false
var wheel_1_should_stop = false

var wheel_2_spinning = false
var wheel_2_should_stop = false

var wheel_1_value = 0
var wheel_2_value = 0

var wait_to_spin = true

func clicked():
	if(wheel_1_spinning == false && wheel_2_spinning == false):
		$AnimationPlayer.play("ArmPull")
		$CoinOpAudio.play()
		wait_to_spin = true
		wheel_1_value = 0
		wheel_2_value = 0
		_delay_timer.start()


func _process(delta):
	if(wheel_1_spinning):
		$Wheel1.rotate_x(spin_speed)
		if(wheel_1_should_stop):
			var target = ((wheel_1_value * 60) - 60)
			$Wheel1.set_rotation_degrees(Vector3(target, 0, 0))
			wheel_1_spinning = false
	
	if(wheel_2_spinning):
		$Wheel2.rotate_x(spin_speed)
		if(wheel_2_should_stop):
			var target = ((wheel_2_value * 60) - 60)
			$Wheel2.set_rotation_degrees(Vector3(target, 0, 0))
			wheel_2_spinning = false

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
