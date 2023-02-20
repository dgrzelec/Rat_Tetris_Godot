extends Control


func _ready():
	pass

func update_score(new_score):
	$ScoreLabel.text = str(new_score)
