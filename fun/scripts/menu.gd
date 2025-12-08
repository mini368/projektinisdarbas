extends Control

@onready var savedata: Label = $Savedata
@onready var animation: AnimationPlayer = $AnimationPlayer

func _on_start_pressed() -> void:
	game_manager.change_level()

func _on_continue_pressed() -> void:
	game_manager.loadit()
	if not game_manager.loaded:
		if not savedata.visible: 
			savedata.visible = true
		else:
			animation.play("nosave")

func _on_exit_pressed() -> void:
	get_tree().quit()
