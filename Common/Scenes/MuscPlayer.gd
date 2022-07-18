extends AudioStreamPlayer

var should_fade_out = false
var should_fade_in = false

func fade_out():
	should_fade_out = true
	should_fade_in = false

func fade_in():
	should_fade_in = true
	should_fade_out = false

func _process(delta):
	if(should_fade_out):
		volume_db -= 0.5
		if(volume_db <= -80):
			should_fade_out = false

	if(should_fade_in):
		volume_db += 0.5
		if(volume_db >= -20):
			should_fade_in = false
