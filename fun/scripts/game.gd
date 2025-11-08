extends Node2D

@onready var coin: Area2D = $Coin

func _on_coin_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
