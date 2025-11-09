extends CharacterBody2D


const SPEED = 80
const JUMP_VELOCITY = -300
var hasjumped = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		hasjumped = 0
	
	var direction := Input.get_axis("left", "right")
	if game_manager.inputs == 1:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and hasjumped < 1: 
			velocity.y = JUMP_VELOCITY
			hasjumped += 1
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if direction == 1:
			animated_sprite.flip_h = false
		elif direction == -1:
			animated_sprite.flip_h = true
		
		if direction:
			if velocity.x >= -1 * SPEED and direction == -1 or velocity.x <= SPEED and direction == 1:
				if is_on_floor():
					velocity.x += direction * SPEED * delta * 5
				elif not is_on_floor():
					velocity.x += direction * SPEED * delta * 3
		else:
			if is_on_floor():
				velocity.x = move_toward(velocity.x, 0, float(SPEED)/15)
			elif not is_on_floor():
				velocity.x = move_toward(velocity.x, 0, float(SPEED)/100)
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play ("jump")
	
	move_and_slide()

@onready var bazooka: Sprite2D = $Bazooka
@onready var rocket = load("res://scenes/rocket.tscn")
@onready var reload: Timer = $Bazooka/Reload
@onready var shape_cast: ShapeCast2D = $ShapeCast2D

func shoot():
	if reload.is_stopped():
		game_manager.removepoint()
		var b = rocket.instantiate()
		owner.add_child(b)
		b.transform = bazooka.transform
		b.position = $".".position + Vector2(0, -5)

var col = 0

func _process(delta: float) -> void:
	
	if shape_cast.is_colliding() and col == 0:
		velocity.x = shape_cast.get_collision_normal(0).x * 200
		velocity.y = shape_cast.get_collision_normal(0).y * 500
		col += 1
	if not shape_cast.is_colliding():
		col = 0
	
	bazooka.rotation = lerp_angle(bazooka.rotation, (bazooka.get_global_mouse_position() - bazooka.global_position).normalized().angle(), delta*10)
	if get_local_mouse_position().x < 0:
		bazooka.flip_v = true
	else:
		bazooka.flip_v = false
	
	if Input.is_action_just_pressed("shoot") and game_manager.inputs == 1:
		if game_manager.shots > 0:
			shoot()
			if reload.is_stopped():
				reload.start()
