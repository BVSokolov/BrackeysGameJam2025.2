extends Control

signal button_continue_pressed
signal button_restart_level_pressed

func _on_button_continue_pressed():
  button_continue_pressed.emit()

func _on_button_restart_level_pressed():
  button_restart_level_pressed.emit()