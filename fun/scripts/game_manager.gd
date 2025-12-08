extends Node

var inputs = 1
var shots = 3
var coins = 0
var lastcoin = 0
var level = 1
@onready var score_label: HBoxContainer = %Score_Label
@onready var timer: Timer = $Timer
@onready var amount: Label = %Amount
@onready var transtimer: Timer = $Transtimer
@onready var gui: Node2D = $CanvasLayer/GUI

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

func deathwoosh():
	$CanvasLayer/Transition/AnimationPlayer.play("fadein")
	await $CanvasLayer/Transition/AnimationPlayer.animation_finished
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	inputs = 1
	resetpoint()
	$CanvasLayer/Transition/AnimationPlayer.play("fadeout")

func startcanvas():
	if not gui.visible:
		gui.visible = true

func change_level():
	$CanvasLayer/Transition/AnimationPlayer.play("fadein")
	inputs = -1
	transtimer.start()
	await transtimer.timeout
	level += 1
	get_tree().change_scene_to_file("res://scenes/level_" + str(level) + ".tscn")
	startcanvas()
	level_changed()
	$CanvasLayer/Transition/AnimationPlayer.play("fadeout")
	inputs = 1
	save()

func level_changed():
	lastcoin = coins
	resetpoint()

func load_level():
	$CanvasLayer/Transition/AnimationPlayer.play("fadein")
	inputs = -1
	transtimer.start()
	await transtimer.timeout
	get_tree().change_scene_to_file("res://scenes/level_" + str(level) + ".tscn")
	startcanvas()
	resetpoint()
	$CanvasLayer/Transition/AnimationPlayer.play("fadeout")
	inputs = 1

const PATH = "user://save.save"
var loaded = true

func save():
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	file.store_var(level)
	file.store_var(lastcoin)

func loadit():
	if FileAccess.file_exists(PATH):
		var file = FileAccess.open(PATH, FileAccess.READ)
		level = file.get_var()
		lastcoin = file.get_var()
		load_level()
	else:
		loaded = false
