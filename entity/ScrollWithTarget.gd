extends Node3D

@export var target : Node3D

@onready var _camera_target_offset : Vector3 = global_position - target.get_global_position()

func _physics_process(_delta : float):
	# keep at same y and x values
	global_position.z = target.get_global_position().z + _camera_target_offset.z
