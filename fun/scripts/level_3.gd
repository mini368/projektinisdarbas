extends Node2D

@onready var timer: Timer = $Timer

func _on_coin_2_body_entered(_body: Node2D) -> void:
	timer.start()
func _on_timer_timeout() -> void:
	if game_manager.inputs == 1:
		get_tree().change_scene_to_file("res://scenes/level_4.tscn")
		game_manager.level_changed()
