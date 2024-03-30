extends Area3D

@export var push : float
@export var cooldown : float
@export var gravity_strength : float
@export var scroll_speed : float

var _velocity : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$flap_cooldown.wait_time = cooldown

func flap():
	if $flap_cooldown.get_time_left() == 0:
		_velocity += Vector3(0, push, 0)
		$flap_cooldown.start(cooldown)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta : float):
	_velocity += delta * Vector3(0, -gravity_strength, 0)
	position += delta * (_velocity + Vector3(0, 0, scroll_speed))
	
func _input(event : InputEvent):
	if event.is_action_pressed("flap"):
		print("Flapped!")
		flap()
	
  
