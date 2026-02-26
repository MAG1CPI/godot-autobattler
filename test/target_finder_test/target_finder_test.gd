extends Node2D


func _ready() -> void:
  $BattleUnit.stats = $BattleUnit.stats
  $BattleUnit2.stats = $BattleUnit2.stats
  $BattleUnit3.stats = $BattleUnit3.stats
  $BattleUnit.target_finder.target_in_range_changed.connect(func():
    print($BattleUnit.target_finder.targets_in_range)
  )


func _input(event: InputEvent) -> void:
  if event.is_action_pressed("ui_right"):
    $BattleUnit.target_finder.find_target()
    print($BattleUnit.target_finder.target)
