extends Area2D

@export var springForce = 1000


func _on_body_entered(body: Node2D) -> void:
  if body.name == "Player":
    body.apply_impulse(Vector2(0, -springForce))
    $AnimatedSprite2D.play("bounce")


func _on_animated_sprite_2d_animation_finished() -> void:
  if $AnimatedSprite2D.animation == "bounce":
    $AnimatedSprite2D.play("idle")
    
