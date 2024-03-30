extends Node

var highscore : float = 0.0

func update(score : float):
	highscore = max(score, highscore)
	return highscore
