extends Area2D

@onready var timer: Timer = $Timer
@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.25
	body.velocity.y = -300
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	game_manager.deadInputs()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	game_manager.deadInputs()
	get_tree().reload_current_scene()
