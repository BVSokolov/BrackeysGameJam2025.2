extends Node2D

@export var levels: Array[LevelInfo]
var current_level
var levelScene: Level

var total_time: float
var level_timer: float
var start_button_pressed: bool
var level_is_completed: bool

func reset_player(isInnit: bool):
  var pos = levelScene.get_start_pos()
  $StartButton.global_position = pos + Vector2(-$StartButton.size.x / 2, -64)

  if (isInnit):
    $Player.level_init(pos)
  else:
    $Player.reset_pos(pos)

func load_level():
  if (current_level == levels.size()):
    game_won()
    return

  var levelInfo = levels[current_level]

  $Player.show()
  levelScene = levelInfo.resource.instantiate()
  level_is_completed = false
  add_child(levelScene)
  levelScene.player_entered_level_death_zone.connect(_on_player_entered_death_zone)
  levelScene.level_complete.connect(_on_level_complete)
  reset_player(true)
  $StartButton.set("disabled", false)

  total_time = 0.0
  level_timer = 0.0
  $Player.init_level_timers(levelInfo.trophyTime_gold, levelInfo.trophyTime_silver, levelInfo.trophyTime_bronze)
  start_button_pressed = false
  $Camera2D/UI/LevelComplete.set_level_goal_times(levelInfo.trophyTime_gold, levelInfo.trophyTime_silver, levelInfo.trophyTime_bronze)

func start_new_game():
  current_level = 0
  $Camera2D/UI/GameWonHUD.hide()
  $Camera2D/UI/LevelComplete.hide()
  $StartButton.show()
  load_level()

func _ready() -> void:
  start_new_game()

func _process(delta: float) -> void:
  if start_button_pressed and not level_is_completed:
    level_timer += delta
    $Player.update_timer(level_timer)

  
func _on_player_entered_death_zone():
  $Player.kill_player()

func _on_player_death_animation_finished():
  reset_player(false)

func _on_start_button_pressed() -> void:
  $StartButton.set("disabled", false)

  start_button_pressed = true
  $Player._on_start_button_pressed()


func game_won():
  $Player.game_won()
  $Player.hide()
  $Camera2D/UI/GameWonHUD.show_game_won(total_time)
  $StartButton.hide()
  $Camera2D.make_current()

func _on_level_complete():
  # pause the level timer
  level_is_completed = true
  # show level complete ui
  $Camera2D/UI/LevelComplete.show_level_complete(level_timer)
  total_time += level_timer

func _on_level_complete_retry_button_pressed() -> void:
  $Camera2D/UI/LevelComplete.hide()
  load_level()

func _on_level_complete_continue_button_pressed() -> void:
  $Camera2D/UI/LevelComplete.hide()
  levelScene.call_deferred('queue_free')
  current_level += 1
  call_deferred('load_level')


func _on_game_won_hud_start_new_game() -> void:
    start_new_game()
