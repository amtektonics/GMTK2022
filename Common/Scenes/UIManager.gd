extends CanvasLayer

func show_hover_over_text(message:String):
	$UI/CenterContainer/HoverOverText.text = message
	$UI/CenterContainer/HoverOverText.visible = true
	$UI/CenterContainer/Background.visible = true

func hide_hove_over_text():
	$UI/CenterContainer/HoverOverText.text = ""
	$UI/CenterContainer/HoverOverText.visible = false
	$UI/CenterContainer/Background.visible = false


func set_in_hand(message:String):
	$UI/Panel/CC/InHand.text = message
