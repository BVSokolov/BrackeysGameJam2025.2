class_name FinishArea extends Area2D

signal player_entered_finish_area

func _on_body_entered(_player: Player) -> void:
  player_entered_finish_area.emit()
