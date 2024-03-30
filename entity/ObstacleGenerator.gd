extends Node3D

const Pipe : PackedScene = preload("res://entity/obstacle.tscn")

@export var target : Node3D
@export var buffer_distance : float

#var _end_of_obstacles_z : float

func _ready():
	generate()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func generate():
	#target.get_global_position()
	pass
