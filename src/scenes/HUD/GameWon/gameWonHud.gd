extends Control

signal start_new_game

func show_game_won(total_time: float):
	$VBoxContainer/HBoxContainer/Label3.text = str(total_time).pad_decimals(4)
	show()

func _on_button_new_game_pressed() -> void:
	start_new_game.emit()