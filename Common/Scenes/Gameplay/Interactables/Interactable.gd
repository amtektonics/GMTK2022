extends Spatial

class_name Interactable

export var interactable_name = ""

export var mouse_over_text = ""

signal mouse_enter
signal mouse_exit
signal clicked

onready var GamePlayScene = get_parent().get_parent()

func _ready():
	GamePlayScene.register_interactable(self)


func clicked():
	pass


func mouse_enter():
	pass


func mouse_exit():
	pass


func minute_tick():
	pass



#signals
func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if(event.is_pressed() && event.button_index == BUTTON_LEFT):
			clicked()
			emit_signal("clicked")



func _on_Area_mouse_entered():
	mouse_enter()
	emit_signal("mouse_enter", mouse_over_text)



func _on_Area_mouse_exited():
	mouse_exit()
	emit_signal("mouse_exit")
