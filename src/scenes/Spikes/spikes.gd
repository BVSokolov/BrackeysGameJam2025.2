extends Area2D


func _on_body_entered(body: Node2D) -> void:
  if body.name == "Player":
    # Todo kill the player 
    # body.die() for now we will just delete the object but once
    # death is implemented then this can be used
    body.queue_free() 
