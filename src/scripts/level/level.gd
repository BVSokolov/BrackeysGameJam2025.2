class_name Level extends Node2D

signal player_entered_level_death_zone
signal level_complete

func get_start_pos() -> Vector2:
  return $MarkerStart.global_position

func _on_player_entered_death_zone() -> void:
  player_entered_level_death_zone.emit()


func _on_player_entered_finish_area() -> void:
  level_complete.emit()
