extends Interactable


func clicked():
	AudioServer.set_bus_mute(0, not AudioServer.is_bus_mute(0))
