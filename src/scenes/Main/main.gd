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

func level_setup(levelInfo: LevelInfo):
  levelScene = levelInfo.resource.instantiate()
  add_child(levelScene)
  levelScene.player_entered_level_death_zone.connect(_on_player_entered_death_zone)
  levelScene.level_complete.connect(_on_level_complete)
  $Player.init_level_timers(levelInfo.trophyTime_gold, levelInfo.trophyTime_silver, levelInfo.trophyTime_bronze)
  $Camera2D/UI/LevelComplete.set_level_goal_times(levelInfo.trophyTime_gold, levelInfo.trophyTime_silver, levelInfo.trophyTime_bronze)

func game_won():
  $Player.game_won()
  $StartButton.hide()
  $Camera2D/UI/GameWonHUD.show_game_won(total_time)
  $Camera2D.make_current()
  get_tree().paused = true

func load_level(is_new_level: bool):
  if (current_level == levels.size()):
    game_won()
    return

  var levelInfo = levels[current_level]
  if is_new_level:
    level_setup(levelInfo)
  
  $Player.reset_level_timer()
  level_timer = 0.0
  level_is_completed = false
  reset_player(true)
  $StartButton.set("disabled", false)
  start_button_pressed = false

func start_new_game():
  total_time = 0.0
  current_level = 0
  $Camera2D/UI/GameWonHUD.hide()
  $Camera2D/UI/LevelComplete.hide()
  $Camera2D/UI/GamePaused.hide()
  $StartButton.show()
  get_tree().paused = false
  call_deferred('load_level', true)


func _ready() -> void:
  start_new_game()

func _process(delta: float) -> void:
  if Input.is_action_just_pressed('ui_cancel'):
    get_tree().paused = !get_tree().paused
    $Camera2D/UI/GamePaused.set('visible', !$Camera2D/UI/GamePaused.is_visible())

  if start_button_pressed and not level_is_completed:
    level_timer += delta
    $Player.update_timer(level_timer)

  
func _on_player_entered_death_zone():
  $Player.kill_player()

func _on_player_death_animation_finished():
  reset_player(false)

func _on_start_button_pressed() -> void:
  $StartButton.set("disabled", true)
  start_button_pressed = true
  $Player._on_start_button_pressed()

  
func _on_game_won_hud_start_new_game() -> void:
    start_new_game()


func on_game_menu_button_pressed(scene: Control):
  scene.hide()
  get_tree().paused = false

func _on_level_complete():
  level_is_completed = true
  $Camera2D/UI/LevelComplete.show_level_complete(level_timer)
  total_time += level_timer
  get_tree().paused = true

func _on_level_complete_retry_button_pressed() -> void:
  on_game_menu_button_pressed($Camera2D/UI/LevelComplete)
  call_deferred('load_level', false)

func _on_level_complete_continue_button_pressed() -> void:
  current_level += 1
  on_game_menu_button_pressed($Camera2D/UI/LevelComplete)
  levelScene.call_deferred('queue_free')
  call_deferred('load_level', true)


func _on_game_paused_button_continue_pressed() -> void:
  on_game_menu_button_pressed($Camera2D/UI/GamePaused)

func _on_game_paused_button_restart_level_pressed() -> void:
  on_game_menu_button_pressed($Camera2D/UI/GamePaused)
  call_deferred('load_level', false)
