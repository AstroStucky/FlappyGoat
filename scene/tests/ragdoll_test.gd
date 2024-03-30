extends Node3D

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		get_node("goat/goatarmature/Skeleton3D").physical_bones_start_simulation()
