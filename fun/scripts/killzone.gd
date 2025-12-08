extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.4
	body.velocity.y = -300
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	game_manager.deadInputs()

func _on_timer_timeout() -> void:
	game_manager.deathwoosh()
