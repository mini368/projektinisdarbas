extends Node

var inputs = 1
var shots = 3
@onready var score_label: HBoxContainer = %Score_Label
@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	if shots<3:
		shots += 1
		var child = score_label.get_child(shots-1)
		child.self_modulate=Color(1, 1, 1, 1)
	if shots==3:
		timer.stop()
		print("stops")

func removepoint():
	if shots<3 and timer.is_stopped():
		timer.start()
		print("goes")
	shots -= 1
	var child = score_label.get_child(shots)
	child.self_modulate=Color(0, 0, 0, 1)

func deadInputs():
	inputs = -1
