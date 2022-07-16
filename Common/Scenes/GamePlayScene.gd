extends Node

export var valid_rooms = [Vector2(0, 0)]
export var step = Vector2()

export var camera_distance = 8

onready var _camera = $Camera

var _current_room = Vector2()

var _target = Vector3()

var _moving = false

func _ready():
	pass

func handle_input(delta):
	if(Input.is_action_just_pressed("move_up")):
			if(valid_rooms.has(_current_room + Vector2(0, 1))):
				_current_room += Vector2(0, 1)
				_target = Vector3(_current_room.x * step.x, _current_room.y * step.y, 8) 
				_moving = true
		
	if(Input.is_action_just_pressed("move_down")):
		if(valid_rooms.has(_current_room + Vector2(0, -1))):
			_current_room += Vector2(0, -1)
			_target = Vector3(_current_room.x * step.x, _current_room.y * step.y, camera_distance) 
			_moving = true
	
	if(Input.is_action_just_pressed("move_left")):
		if(valid_rooms.has(_current_room + Vector2(-1, 0))):
			_current_room += Vector2(-1, 0)
			_target = Vector3(_current_room.x * step.x, _current_room.y * step.y, camera_distance) 
			_moving = true
	
	if(Input.is_action_just_pressed("move_right")):
		if(valid_rooms.has(_current_room + Vector2(1, 0))):
			_current_room += Vector2(1, 0)
			_target = Vector3(_current_room.x * step.x, _current_room.y * step.y, camera_distance) 
			_moving = true


func _process(delta):
	if(!_moving):
		handle_input(delta)
		
	else:
		if(_camera.transform.origin.distance_to(_target) < 0.03):
			_camera.transform.origin = _target
			_moving = false
		else:
			_camera.transform.origin = lerp(_camera.transform.origin, _target, 0.1)


func _on_Stove_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if(event.is_pressed() && event.button_index == BUTTON_LEFT):
			print("yes")
