extends Control

signal start_new_game

func _on_button_new_game_pressed() -> void:
	start_new_game.emit()