extends GridMap

@export var backdrop : Node3D
@onready var _initial_position : Vector3 = position

var partner : GridMap = null
var _width : float = 0

func _ready():
	# z-distance between decoration as lowest z-value and highest z-value
	var max_iz : int = get_used_cells()[0].z
	var min_iz : int = get_used_cells()[0].z
	var min_corner : Vector3
	var max_corner : Vector3
	for c in get_used_cells():
		if c.z > max_iz:
			max_iz = c.z
			max_corner = map_to_local(c)
		if c.z < min_iz:
			min_iz = c.z
			min_corner = map_to_local(c)
	_width = (max_corner - min_corner).z
	
	$Floor.get_mesh().set_size(Vector2(_width, _width)) # make square so texture is not stretched
	$Floor.set_position(Vector3(0, cell_size.y / 2, _width / 2))

	$ShiftThreshold.set_position(Vector3(0, 0, _width / 2))
	$ShiftThreshold.area_entered.connect(_on_area_shift_threshold_entered)
	if not is_instance_valid(partner):
		# code ran by first instance
		partner = duplicate()
		partner.partner = self
		partner.set_position(Vector3(_initial_position.x, _initial_position.y, position.z - _width))
		get_parent().add_child.call_deferred(partner)
		
func _on_area_shift_threshold_entered(_area):
	leapfrog()
	
func leapfrog():
	partner.position.z += 2 * _width
	
