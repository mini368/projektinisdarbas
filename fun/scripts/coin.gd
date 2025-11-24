extends Area2D

@onready var pickup_anim: AnimationPlayer = $PickupAnim

func _on_body_entered(_body: Node2D) -> void:
	pickup_anim.play("pickup")
