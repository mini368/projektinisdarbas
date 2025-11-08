extends Area2D

@onready var game_manager: Node = %GameManager
@onready var pickup_anim: AnimationPlayer = $PickupAnim

func _on_body_entered(body: Node2D) -> void:
	game_manager.addpoint()
	pickup_anim.play("pickup")
