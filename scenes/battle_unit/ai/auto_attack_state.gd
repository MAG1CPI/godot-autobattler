extends State
class_name AutoAttackState


var actor_unit: BattleUnit
var target: BattleUnit


func _init(new_actor: Node, new_target: BattleUnit) -> void:
  actor = new_actor
  target = new_target


func enter() -> void:
  actor_unit = actor as BattleUnit
  print("%s ATTACKING[TODO]" % actor_unit.name)
