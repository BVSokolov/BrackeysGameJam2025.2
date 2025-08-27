extends Control

func set_time_goals(gold: float, silver: float, bronze: float):
  $MarginContainer/VBoxContainer/VBoxContainer/LevelTimeTrophyGoal/Label.text = str(gold).pad_decimals(4)
  $MarginContainer/VBoxContainer/VBoxContainer/LevelTimeTrophyGoal2/Label.text = str(silver).pad_decimals(4)
  $MarginContainer/VBoxContainer/VBoxContainer/LevelTimeTrophyGoal3/Label.text = str(bronze).pad_decimals(4)

func update_level_timer(time: float):
  $MarginContainer/VBoxContainer/Label.text = str(time).pad_decimals(4)
