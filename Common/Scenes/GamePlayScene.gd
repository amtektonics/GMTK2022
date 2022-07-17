extends Node

export var valid_rooms = [Vector2(0, 0)]
export var step = Vector2()

export var camera_distance = 8

onready var hand_inventory = $CanvasLayer/UI/HandInventory

onready var inventory = $CanvasLayer/UI/Inventory

onready var _camera = $Camera

var _current_room = Vector2()

var _target = Vector3()

var _moving = false

onready var _cl = $CanvasLayer

onready var _mouse_item_texture = $CanvasLayer/MouseItem

var interactables = []

var _day = 0
var _minute = 0
var _hour = 0

var _mouse_item = null
var _mouse_item_amount = 0


func _ready():
	randomize()
	hand_inventory.add_item(Globals.MYSTERY_SEED_ITEM, 3)
	
	
func register_interactable(i):
	interactables.append(i)
	i.connect("mouse_enter", self, "interactable_mouse_enter")
	i.connect("mouse_exit", self, "interactable_mouse_exit")
	i.connect("clicked", self, "_interactable_clicked")


func step_minute():
	_minute += 10
	if(_minute >= 60):
		_minute = 0
		_hour += 1
	if(_hour >= 24):
		_hour = 0
		_day += 1
	$CanvasLayer/UI/Panel/CC/Time.text = ("Day: %d \n %02d:%02d" % [_day, _hour, _minute]) 
	for i in interactables:
		i.minute_tick()


func handle_input(delta):
	if(Input.is_action_just_pressed("move_up")):
			if(valid_rooms.has(_current_room + Vector2(0, 1))):
				_current_room += Vector2(0, 1)
				_target = Vector3(_current_room.x * step.x, _current_room.y * step.y, 8) 
				_moving = true
				hide_inventory()
		
	if(Input.is_action_just_pressed("move_down")):
		if(valid_rooms.has(_current_room + Vector2(0, -1))):
			_current_room += Vector2(0, -1)
			_target = Vector3(_current_room.x * step.x, _current_room.y * step.y, camera_distance) 
			_moving = true
			hide_inventory()
	
	if(Input.is_action_just_pressed("move_left")):
		if(valid_rooms.has(_current_room + Vector2(-1, 0))):
			_current_room += Vector2(-1, 0)
			_target = Vector3(_current_room.x * step.x, _current_room.y * step.y, camera_distance) 
			_moving = true
			hide_inventory()
	
	if(Input.is_action_just_pressed("move_right")):
		if(valid_rooms.has(_current_room + Vector2(1, 0))):
			_current_room += Vector2(1, 0)
			_target = Vector3(_current_room.x * step.x, _current_room.y * step.y, camera_distance) 
			_moving = true
			hide_inventory()
		
	if(Input.is_action_just_pressed("ui_cancel")):
		inventory.add_item(Globals.POTATO_ITEM, 1)
		inventory.add_item(Globals.MYSTERY_SEED, 1)
	

func _process(delta):
	if(!_moving):
		handle_input(delta)
	else:
		if(_camera.transform.origin.distance_to(_target) < 0.03):
			_camera.transform.origin = _target
			_moving = false
		else:
			_camera.transform.origin = lerp(_camera.transform.origin, _target, 0.1)
	
	_mouse_item_texture.rect_position = get_viewport().get_mouse_position() + Vector2(-32, -32)

func show_inventory():
	$CanvasLayer/UI/Inventory.visible = true

func hide_inventory():
	$CanvasLayer/UI/Inventory.visible = false

func is_inventory_visible():
	return $CanvasLayer/UI/Inventory.visible


func get_mouse_item():
	return _mouse_item

func get_mouse_item_amount():
	return _mouse_item_amount

func set_mouse_item(item, amount):
	_mouse_item = item
	_mouse_item_amount = amount
	if(item != null):
		_mouse_item_texture.texture = item.texture
	else:
		_mouse_item_texture.texture = null

func remove_mouse_item_amount(amount):
	if(_mouse_item_amount > amount):
		_mouse_item_amount -= amount
	else:
		clear_mouse_item()

func clear_mouse_item():
	_mouse_item = null
	_mouse_item_amount = 0
	_mouse_item_texture.texture = null

#signals
func interactable_mouse_enter(message):
	if(message != ""):
		_cl.show_hover_over_text(message)

func interactable_mouse_exit():
	_cl.hide_hove_over_text()


func _on_MinuteTimer_timeout():
	step_minute()
