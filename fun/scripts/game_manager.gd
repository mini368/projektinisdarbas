extends Node

var score = 0
var inputs = 1
@onready var score_label: Label = $Score_Label

func addpoint():
	score += 1
	score_label.text = str(score) + " coins"

func deadInputs():
	inputs = -1
