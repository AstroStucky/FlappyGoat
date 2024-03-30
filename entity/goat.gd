extends Area3D

@export var push : float
@export var cooldown : float
@export var gravity_strength : float
@export var scroll_speed : float

signal killed

var _velocity : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$flap_cooldown.wait_time = cooldown
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	kill()

func _physics_process(delta : float):
	_velocity += delta * Vector3(0, -gravity_strength, 0)
	position += delta * (_velocity + Vector3(0, 0, scroll_speed))
	
func _input(event : InputEvent):
	if event.is_action_pressed("flap"):
		flap()

func flap():
	if $flap_cooldown.get_time_left() == 0:
		_velocity += Vector3(0, push, 0)
		$goat/AnimationPlayer.play("goatarmature")
		$flap_cooldown.start(cooldown)
	
func kill():
	print_debug("Goat killed!")
	body_entered.disconnect(_on_body_entered)
	$goat/goatarmature/Skeleton3D.physical_bones_start_simulation()
	_velocity = Vector3.ZERO
	scroll_speed = 0.0 
	killed.emit()
  
