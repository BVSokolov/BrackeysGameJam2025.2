class_name Player extends RigidBody2D

@export var forcePower = 34000

# var screenSize

# func _ready() -> void:
#   screenSize = get_viewport_rect().size

func process_move(dt: float) -> void:
  # pass
  var force = Vector2.ZERO
  if Input.is_action_pressed('ui_left'):
    force.x -= 1
  if Input.is_action_pressed('ui_right'):
    force.x += 1

  if force.length() > 0:
    force = force.normalized() * forcePower

  apply_force(force * dt)

func _process(dt: float) -> void:
  process_move(dt)
