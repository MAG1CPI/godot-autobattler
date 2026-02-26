extends Resource
class_name GameState


enum Phase {
  PREPARATION,
  BATTLE,
}


@export var current_phase: Phase:
  set(new_phase):
    current_phase = new_phase
    changed.emit()


func is_battling() -> bool:
  return current_phase == Phase.BATTLE
