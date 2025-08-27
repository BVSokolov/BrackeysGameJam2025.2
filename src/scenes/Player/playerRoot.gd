extends Node2D

var player: Player

signal player_death_animation_finished

func _ready() -> void:
  player = $RigidBody2D

func level_init(pos: Vector2):
  player.level_init(pos)

func reset_pos(pos: Vector2):
  player.reset_pos(pos)

func kill_player():
  player.kill_player()
  $HoDSprite2D/AnimationPlayer.play('player_death')

func game_won():
  player.game_won()

func _on_start_button_pressed():
  player._on_start_button_pressed()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
  if (anim_name != "RESET"):
    player_death_animation_finished.emit()
    $HoDSprite2D/AnimationPlayer.play("RESET")
