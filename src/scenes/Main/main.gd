extends Node2D

@export var levels: Array[PackedScene]
var current_level
var levelScene: Level

func reset_player(isInnit: bool):
  var pos = levelScene.get_start_pos()
  $StartButton.global_position = pos + Vector2(-$StartButton.size.x / 2, -64)

  if (isInnit):
    $Player.level_init(pos)
  else:
    $Player.reset_pos(pos)

func load_level():
  $Player.show()
  levelScene = levels[current_level].instantiate()
  add_child(levelScene)
  levelScene.player_entered_level_death_zone.connect(_on_player_entered_death_zone)
  levelScene.level_complete.connect(_on_level_complete)
  reset_player(true)

func start_new_game():
  current_level = 0
  $GameWonHUD.hide()
  $StartButton.show()
  load_level()

func _ready() -> void:
  start_new_game()

  
func _on_player_entered_death_zone():
  $Player.kill_player()

func _on_player_death_animation_finished():
  reset_player(false)

func _on_start_button_pressed() -> void:
  $Player._on_start_button_pressed()


func game_won():
  $Player.game_won()
  $GameWonHUD.show()
  $StartButton.hide()
  $Camera2D.make_current()

func _on_level_complete():
  levelScene.call_deferred('queue_free')
  if (current_level == levels.size() - 1):
    game_won()
  else:
    current_level += 1
    call_deferred('load_level')


func _on_game_won_hud_start_new_game() -> void:
    start_new_game()
