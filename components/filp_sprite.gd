extends Node
class_name FlipSprite


@export var sprite: Sprite2D


func flip_sprite_towards(other_position: Vector2) -> void:
  var new_dir: Vector2 = sprite.global_position.direction_to(other_position)
  var new_dir_sign: float = sign(new_dir.x)
  if new_dir_sign == 0: return
  sprite.flip_h = new_dir_sign == 1
