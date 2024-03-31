extends Control

@export var reset_pause_wait : float

func set_verbage(verb : String):
  $Label.text = STATEMENT % verb

const STATEMENT : String = "Press Left Click or Spacebar to %s"

var await_input : bool = false

func _ready():
  # trigger reset pause screen countdown on goat killed
  var goats = get_tree().get_nodes_in_group('Goat')
  if goats.size() == 0:
    push_error("No goat in scene!")
    return
  goats[0].killed.connect(_on_goat_killed)
  # begin scene paused with "Begin" verbage
  set_verbage("Begin")
  pause()

func _on_goat_killed():
  # wait several seconds before game pause
  await get_tree().create_timer(reset_pause_wait).timeout
  set_verbage("Reset")
  pause()

func pause():
  await_input = true
  set_visible(true)
  get_tree().set_pause(true)

func unpause():
  await_input = false
  set_visible(false)
  get_tree().set_pause(false)

# func _ready():
#   $Label.text = STATEMENT % verbage

func _input(event : InputEvent):
  if await_input and event.is_action_pressed('flap'):
    print('unpause')
    unpause()

