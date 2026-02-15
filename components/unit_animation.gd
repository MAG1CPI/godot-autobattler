extends Node
class_name UnitAnimations


const COMBINE_ANIM_LENGTH := 0.6
const COMBINE_ANIM_SCALE := Vector2(0.7, 0.7)
const COMBINE_ANIM_ALPHA := 0.5


@export var unit: Unit


func play_combine_animation(target_position: Vector2) -> void:
  unit.health_bar.hide()
  unit.mana_bar.hide()
  unit.tier_icon.hide()

  var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
  tween.tween_property(unit, "global_position", target_position, COMBINE_ANIM_LENGTH)
  tween.parallel().tween_property(unit, "scale", COMBINE_ANIM_SCALE, COMBINE_ANIM_LENGTH)
  tween.parallel().tween_property(unit, "modulate:a", COMBINE_ANIM_ALPHA, COMBINE_ANIM_LENGTH)
  tween.tween_callback(unit.queue_free)
