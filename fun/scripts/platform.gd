extends AnimatableBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var t = 1

func _process(delta: float) -> void:
	if t>=0:
		t -= delta * 10
	if Input.is_action_pressed("down"):
		collision_shape_2d.disabled = true
		t = 1
	elif t < 0:
		collision_shape_2d.disabled = false
	
