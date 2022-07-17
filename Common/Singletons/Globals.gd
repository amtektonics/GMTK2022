extends Node

var Items = {}

onready var POTATO_ITEM = PotatoItem.new(1)
onready var MYSTERY_SEED_ITEM = MysterySeedItem.new(2)
onready var BREAD_ITEM = BreadItem.new(3)

func _ready():
	Items[1] = POTATO_ITEM
	Items[2] = MYSTERY_SEED_ITEM
	Items[3] = BREAD_ITEM
