class_name DeatZone extends Area2D

signal player_entered_death_zone

func _on_body_entered(_player: Player) -> void:
	player_entered_death_zone.emit()
