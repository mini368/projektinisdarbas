extends Node

var inputs = 1
var shots = 3
var coins = 0
var lastcoin = 0
@onready var score_label: HBoxContainer = %Score_Label
@onready var timer: Timer = $Timer
@onready var amount: Label = %Amount

func _on_timer_timeout() -> void:
	if shots<3:
		shots += 1
		var child = score_label.get_child(shots-1)
		child.self_modulate=Color(1, 1, 1, 1)
	if shots==3:
		timer.stop()

func resetpoint():
	shots = 3
	var child = score_label.get_children()
	for x in 3:
		child[x].self_modulate=Color(1, 1, 1, 1)
	amount.text = str(lastcoin)
	coins = lastcoin

func removepoint():
	if shots<3 and timer.is_stopped():
		timer.start()
	shots -= 1
	var child = score_label.get_child(shots)
	child.self_modulate=Color(0, 0, 0, 1)

func coin():
	coins += 1
	amount.text = str(coins)

func deadInputs():
	inputs = -1

func level_changed():
	lastcoin = coins
