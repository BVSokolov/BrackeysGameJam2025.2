class_name LevelComplete extends Control

signal continue_button_pressed
signal retry_button_pressed

@export var gold_trophy: CompressedTexture2D
@export var silver_trophy: CompressedTexture2D
@export var bronze_trophy: CompressedTexture2D
@export var participation_trophy: CompressedTexture2D
const participation_text = 'participation trophy'

var gold_time: float
var silver_time: float
var bronze_time: float

func set_level_goal_times(gold: float, silver: float, bronze: float):
  gold_time = gold
  silver_time = silver
  bronze_time = bronze
  $Panel/MarginContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Button2.hide()

func show_level_complete(level_time: float):
  var trophy_data = [ {resource = gold_trophy, goal_time = gold_time, name = 'gold trophy'}, {resource = silver_trophy, goal_time = silver_time, name = 'silver trophy'}, {resource = bronze_trophy, goal_time = bronze_time, name = 'bronze trophy'}]
  var resource = participation_trophy
  var text = participation_text
  
  for data in trophy_data:
    print(data.resource, data.goal_time)
    if level_time < data.goal_time:
      resource = data.resource
      text = data.name
      $Panel/MarginContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Button2.show()
      break
  $Panel/MarginContainer/Panel/MarginContainer/VBoxContainer/TextureRect.texture = resource
  $Panel/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/Label2.text = text
  show()


func _on_continue_button_pressed() -> void:
  continue_button_pressed.emit()

func _on_retry_button_pressed() -> void:
  retry_button_pressed.emit()