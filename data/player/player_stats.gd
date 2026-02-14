extends Resource
class_name PlayerStats


const XP_REQUIREMENTS := {
  1: 0,
  2: 2,
  3: 2,
  4: 6,
  5: 10,
  6: 20,
  7: 36,
  8: 48,
  9: 76,
  10: 76,
  11: 99999,
}


@export_range(0, 99) var gold: int = 0: set = _set_gold
@export_range(0, 99) var xp: int = 0: set = _set_xp
@export_range(1, 10) var level: int = 1: set = _set_level


func get_current_xp_requirement() -> int:
  return XP_REQUIREMENTS[level + 1]


func _set_gold(new_gold: int) -> void:
  gold = new_gold
  emit_changed()


func _set_xp(new_xp: int) -> void:
  xp = new_xp
  emit_changed()
  var xp_requirement: int = get_current_xp_requirement()
  while xp >= xp_requirement:
    level += 1
    xp -= xp_requirement
    xp_requirement = get_current_xp_requirement()
    emit_changed()


func _set_level(new_level: int) -> void:
  level = new_level
  emit_changed()
