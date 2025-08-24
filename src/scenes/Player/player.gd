class_name Player extends Node2D

@export var speed = 400

var screenSize

func _ready() -> void:
  screenSize = get_viewport_rect().size

func process_move(delta: float) -> void:
  var velocity = Vector2.ZERO
  if Input.is_action_pressed('ui_left'):
    velocity.x -= 1
  if Input.is_action_pressed('ui_right'):
    velocity.x += 1

  if velocity.length() > 0:
    velocity = velocity.normalized() * speed

  position += velocity * delta
  position = position.clamp(Vector2.ZERO, screenSize)

func _process(delta: float) -> void:
  process_move(delta)