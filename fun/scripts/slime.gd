extends Node2D

const SPEED = 20

var direction = 1

@onready var ray_cast_r: RayCast2D = $RayCastR
@onready var ray_cast_l: RayCast2D = $RayCastL
@onready var ray_cast_down_r: RayCast2D = $RayCastDownR
@onready var ray_cast_down_l: RayCast2D = $RayCastDownL
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_r.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_l.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	if not ray_cast_down_r.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if not ray_cast_down_l.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta
