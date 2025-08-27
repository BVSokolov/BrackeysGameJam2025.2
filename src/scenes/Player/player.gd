class_name Player extends RigidBody2D

@export var torqePower = 35000
@export var forcePower = 1000
@export var jumpForcePower = 500
var onGround = true

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

  if Input.is_action_just_pressed('jump') && onGround:
    apply_impulse(Vector2(0, -jumpForcePower))
    
  if forceDirX != 0:
    apply_torque(forceDirX * torqePower)
    # if !onGround:
      # var inAirForce = Vector2(forceDirX, 0.5)
      # apply_force(inAirForce.normalized() * forcePower) //allows in air movement
    
func _physics_process(dt: float) -> void:
  process_move(dt)

func _on_area_2d_body_entered(_body: Node2D) -> void:
  onGround = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
  onGround = false

func level_init(pos: Vector2):
  set_deferred('freeze', true)
  global_position = pos
  $Camera2D.make_current()
  # linear_velocity = Vector2.ZERO
  # gravity_scale = 0

func reset_pos(pos: Vector2):
  set_deferred('freeze', false)

  PhysicsServer2D.body_set_state(
    get_rid(),
    PhysicsServer2D.BODY_STATE_TRANSFORM,
    Transform2D.IDENTITY.translated(pos)
  )
  linear_velocity = Vector2.ZERO
  # gravity_scale = 0

func _on_start_button_pressed():
  # set_freeze_enabled(false)
  set_deferred('freeze', false)
  # gravity_scale = 1

func game_won():
  set_deferred('freeze', true)

func kill_player():
  set_deferred('freeze', true)
  rotation = 0
