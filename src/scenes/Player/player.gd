class_name Player extends RigidBody2D

@export var torqePower = 35000
@export var jumpForcePower = 500
var groundCollider: Area2D

func process_move(_dt: float) -> void:
  var forceDirX = 0
  if Input.is_action_pressed('ui_left'):
    forceDirX -= 1
  if Input.is_action_pressed('ui_right'):
    forceDirX += 1
  if Input.is_action_just_pressed('ui_select') && groundCollider.has_overlapping_bodies():
    apply_impulse(Vector2(0, -jumpForcePower))
  if forceDirX != 0:
    apply_torque(forceDirX * torqePower)
    
func _physics_process(dt: float) -> void:
  process_move(dt)

func level_init(pos: Vector2):
  global_position = pos
  set_deferred('freeze', true)
  set_physics_process(false)
  $Camera2D.make_current()

func reset_pos(pos: Vector2):
  PhysicsServer2D.body_set_state(
    get_rid(),
    PhysicsServer2D.BODY_STATE_TRANSFORM,
    Transform2D.IDENTITY.translated(pos)
  )
  linear_velocity = Vector2.ZERO
  set_physics_process(true)
  set_deferred('freeze', false)

func _on_start_button_pressed():
  set_physics_process(true)
  set_deferred('freeze', false)

func game_won():
  set_physics_process(false)


func kill_player():
  rotation = 0
  set_physics_process(false)
  set_deferred('freeze', true)
