extends Area2D

@onready var shape_cast: ShapeCast2D = $ShapeCast2D

func _process(_delta: float) -> void:
	if shape_cast.is_colliding() and Input.is_action_pressed("tp") and game_manager.inputs == 1:
		game_manager.change_level()
