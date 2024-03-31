extends Node

var resetable : bool = false

func await_reset():
	resetable = true
	
func reset():
	get_tree().reload_current_scene()
	resetable = false

func _input(event : InputEvent):
	if resetable and event.is_action_pressed("flap"):
		reset()
