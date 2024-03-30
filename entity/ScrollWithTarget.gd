extends Node3D

@export var target : Node3D

#var _original_position : Vector3
var _camera_target_offset : Vector3

func _ready():
	_camera_target_offset = global_position - target.get_global_position()
	
func _physics_process(_delta):
	# keep at same y and x values
	global_position.z = target.get_global_position().z + _camera_target_offset.z
