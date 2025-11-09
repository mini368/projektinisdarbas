extends Node2D

@onready var timer: Timer = $Timer

func _on_coin_body_entered(_body: Node2D) -> void:
	timer.start()
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
