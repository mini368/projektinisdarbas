extends Area2D

var speed = 200

func _physics_process(delta):
	position += transform.x * speed * delta
	
func _on_body_entered(_body: Node2D) -> void:
	print("POW")
	queue_free()
