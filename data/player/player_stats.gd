extends Resource
class_name PlayerStats


@export_range(0, 99) var gold: int: set = _set_gold
@export_range(0, 99) var xp: int: set = _set_xp
@export_range(1, 10) var level: int: set = _set_level


func _set_gold(new_gold: int) -> void:
  gold = new_gold
  emit_changed()


func _set_xp(new_xp: int) -> void:
  xp = new_xp
  emit_changed()


func _set_level(new_level: int) -> void:
  level = new_level
  emit_changed()
