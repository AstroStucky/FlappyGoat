extends Control

@onready var distance = $VBoxContainer/Distance/Number
@onready var highscore = $VBoxContainer/Highscore/Number

var _player : Node3D
var _score : float

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_tree().get_nodes_in_group('Goat')[0]
	_player.killed.connect(_on_player_killed)
	highscore.text = String.num(ScoreKeeper.highscore, 2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_score = _player.global_position.z
	distance.text = String.num(_score, 2)

func _on_player_killed():
	highscore.text = String.num(ScoreKeeper.update(_score), 2)
