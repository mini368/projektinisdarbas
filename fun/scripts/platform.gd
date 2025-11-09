extends AnimatableBody2D

@onready var game_manager: Node = %GameManager
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var shape_cast: ShapeCast2D = $ShapeCast2D
var t = 1

func _process(delta: float) -> void:
	if t>=0:
		t -= delta * 10
	if Input.is_action_pressed("down") and game_manager.inputs == 1 and shape_cast.is_colliding():
		collision_shape_2d.disabled = true
		t = 1
	elif t < 0:
		collision_shape_2d.disabled = false
	
