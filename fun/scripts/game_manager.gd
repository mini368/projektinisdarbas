extends Node


var inputs = 1
var shots = 300
@onready var score_label: Label = $Score_Label

func _on_ready() -> void:
	score_label.text = str(shots) + " shots left."

func addpoint():
	shots += 3
	score_label.text = str(shots) + " shots left."

func removepoint():
	shots -= 1
	score_label.text = str(shots) + " shots left."

func deadInputs():
	inputs = -1
