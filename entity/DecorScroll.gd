extends GridMap

var _duplicate_offset : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	$DuplicateBoundary.area_entered.connect(_on_area_entered_duplication_boundary)
	_duplicate_offset = Vector3(0, 0, $DuplicateBoundary.get_position().z)
	
func _on_area_entered_duplication_boundary(area):
	duplicate_ahead()

func duplicate_ahead():
	var new_self : GridMap = duplicate()
	new_self.set_position(position + _duplicate_offset)
	get_parent().add_child(new_self)
