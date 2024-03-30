extends Node3D

@export var library : MeshLibrary

var gap : float
var ypos : float

const PIPES := ['Pipe_Blue', 'Pipe_Red', 'Pipe_Green', 'Pipe_Orange', 'Pipe_Purple']

var _pipes : Array

func _ready():
	var pipe_indices := []
	for p in PIPES:
		pipe_indices.append(library.find_item_by_name(p))
	var m : int = pipe_indices.pick_random()
	$top/MeshInstance3D.set_mesh(library.get_item_mesh(m))
	$bottom/MeshInstance3D.set_mesh(library.get_item_mesh(m))
	$top.position.y    = ypos + gap / 2
	$bottom.position.y = ypos - gap / 2

func randomize(gap_min : float, gap_max : float, ypos_min : float, ypos_max : float):
	gap = randf_range(gap_min, gap_max)
	ypos = randf_range(ypos_min, ypos_max)
	
