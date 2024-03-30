extends Node3D

const Obstacle : PackedScene = preload("res://entity/obstacle.tscn")

@export var obstacle_spacing : float
@export var target : Node3D
@export var batch_width : float
@export var initial_clearing : float
@export var min_gap : float
@export var max_gap : float
@export var y_height : float

@onready var _end_of_obstacles_z : float = target.global_position.z
@onready var _batch_size : int = int(ceil(batch_width / obstacle_spacing))

func _ready():
	generate_and_cleanup(2)
	
func _process(_delta):
	if target.global_position.z > _end_of_obstacles_z - batch_width / 2:
		generate_and_cleanup()

func generate_and_cleanup(batch_multiplier : int = 1):
	print_debug("Generating more obstacles")
	var start_z : float
	if get_child_count() == 0:
		start_z = target.global_position.z + initial_clearing
	else:
		# start from most recently added obstacle
		start_z = get_child(-1).position.z
		# cleanup 
		for i in range(_batch_size):
			get_child(i).queue_free()
	for i in range(_batch_size * batch_multiplier):
		var obstacle = Obstacle.instantiate()
		obstacle.position.z = start_z + obstacle_spacing * (i + 1)
		obstacle.randomize(min_gap, max_gap, -y_height/2, y_height/2)
		add_child(obstacle)
	_end_of_obstacles_z = get_child(-1).position.z
