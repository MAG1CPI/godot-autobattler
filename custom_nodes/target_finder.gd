extends Node
class_name TargetFinder


signal targets_in_range_changed()


@export var actor: BattleUnit


var target: BattleUnit
var targets_in_range: Array[BattleUnit]


func _ready() -> void:
  actor.ready.connect(func():
    actor.detect_range.area_entered.connect(_on_area_entered)
    actor.detect_range.area_exited.connect(_on_area_exited)
    , CONNECT_ONE_SHOT
  )


func find_target() -> void:
  var opposing_group: String = UnitStats.TARGET[actor.stats.team]
  var all_targets := actor.get_tree().get_nodes_in_group(opposing_group)
  var distances_squared := all_targets.map(
    func(target_candiate: BattleUnit) -> float:
      return actor.global_position.distance_squared_to(target_candiate.global_position)
  )
  var idx := distances_squared.find(distances_squared.min())
  target = all_targets[idx]


func has_target_in_range() -> bool:
  return targets_in_range.size() > 0


func _on_area_entered(area: Area2D) -> void:
  var unit := _get_battle_unit_from_area(area)
  if not unit: return
  targets_in_range.append(unit)
  targets_in_range_changed.emit()


func _on_area_exited(area: Area2D) -> void:
  var unit := _get_battle_unit_from_area(area)
  if not unit: return
  targets_in_range.erase(unit)
  targets_in_range_changed.emit()


func _get_battle_unit_from_area(area: Area2D) -> BattleUnit:
  if area is BattleUnit:
    return area
  if area is HurtBox and area.get_parent() is BattleUnit:
    return area.get_parent()
  if area.get_parent() is BattleUnit:
    return area.get_parent()
  return null
