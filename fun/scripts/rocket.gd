extends Area2D

var speed = 500
var entered = false
var times = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var expduration: Timer = $Expduration
@onready var rocketanims: AnimationPlayer = $Rocketanims

func _physics_process(delta):
	if not entered:
		position += transform.x * speed * delta
		
func _process(_delta: float) -> void:
	if entered and times < 1:
		times += 1
		animated_sprite.play("boom")
		rocketanims.play("theboom")
		animated_sprite.rotation = randi_range(-3, 3)
		set_collision_layer_value(3, true)
		var cir = CircleShape2D.new()
		cir.radius = 35
		collision_shape.shape = cir

func _on_body_entered(_body: Node2D) -> void:
	expduration.start()
	entered = true

func _on_area_entered(_area: Area2D) -> void:
	expduration.start()
	entered = true

func _on_timer_timeout() -> void:
	queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite.queue_free()

func _on_expduration_timeout() -> void:
	collision_shape.disabled = true
