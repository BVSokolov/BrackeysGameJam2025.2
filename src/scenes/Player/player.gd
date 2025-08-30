class_name Player extends RigidBody2D

@export var torqePower = 35000
@export var forcePower = 1000
@export var jumpForcePower = 500
var groundCollider: Area2D

# var screenSize

# func _ready() -> void:
#   screenSize = get_viewport_rect().size

func process_move(_dt: float) -> void:
  # pass
  var forceDirX = 0
  if Input.is_action_pressed('ui_left'):
    forceDirX -= 1
  if Input.is_action_pressed('ui_right'):
    forceDirX += 1

  if Input.is_action_just_pressed('jump') && groundCollider.has_overlapping_bodies():
    apply_impulse(Vector2(0, -jumpForcePower))
    
  if forceDirX != 0:
    apply_torque(forceDirX * torqePower)
    # if !onGround:
      # var inAirForce = Vector2(forceDirX, 0.5)
      # apply_force(inAirForce.normalized() * forcePower) //allows in air movement
    
func _physics_process(dt: float) -> void:
  process_move(dt)

func level_init(pos: Vector2):
  global_position = pos
  set_deferred('freeze', true)
  set_physics_process(false)
  $Camera2D.make_current()
  # get_tree().paused = true

  # linear_velocity = Vector2.ZERO
  # gravity_scale = 0

func reset_pos(pos: Vector2):
  # get_tree().paused = false
  PhysicsServer2D.body_set_state(
    get_rid(),
    PhysicsServer2D.BODY_STATE_TRANSFORM,
    Transform2D.IDENTITY.translated(pos)
  )
  linear_velocity = Vector2.ZERO
  set_physics_process(true)
  set_deferred('freeze', false)
  # gravity_scale = 0

func _on_start_button_pressed():
  # set_freeze_enabled(false)
  # get_tree().paused = false
  set_physics_process(true)
  set_deferred('freeze', false)
  # gravity_scale = 1

func game_won():
  # set_deferred('freeze', true)
  # get_tree().paused = true
  set_physics_process(false)


func kill_player():
  rotation = 0
  set_deferred('freeze', true)
  set_physics_process(false)
  # get_tree().paused = true
