extends Area2D

var speed = 200
var entered = false
var times = 0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var expduration: Timer = $Expduration

func _physics_process(delta):
	if not entered:
		position += transform.x * speed * delta
		
func _process(_delta: float) -> void:
	if entered and times < 1:
		var cir = CircleShape2D.new()
		cir.radius = 35
		collision_shape.shape = cir
		times += 1

func _on_body_entered(body: Node2D) -> void:
	expduration.start()
	entered = true
	animated_sprite.play("boom")
	if body is CharacterBody2D:
		print("a")
		body.velocity.y = -400

func _on_timer_timeout() -> void:
	queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()

func _on_expduration_timeout() -> void:
	collision_shape.disabled = true
