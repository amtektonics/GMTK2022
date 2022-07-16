extends Node


var _active_scene = null

onready var _main_menu = load("res://Common/Scenes/MainMenuScene.tscn")

onready var _game_play = load("res://Common/Scenes/GamePlayScene.tscn")

func _ready():
	load_game_play()


func load_main_menu():
	if(_active_scene != null):
		_active_scene.queue_free()
		_active_scene = null
	_active_scene = _main_menu.instance()
	add_child(_active_scene)


func load_game_play():
	if(_active_scene != null):
		_active_scene.queue_free()
		_active_scene = null
	_active_scene = _game_play.instance()
	add_child(_active_scene)
