extends Area2D
class_name DetectRange

@export var col_shape: CollisionShape2D
@export var base_range_size: float
@export var stats: UnitStats:
  set(new_stats):
    stats = new_stats

    var shape := CircleShape2D.new()

    if not stats:
      shape.radius = 0
      col_shape.shape = shape
      return

    shape.radius = base_range_size * stats.attack_range
    col_shape.shape = shape
    collision_layer = 0b0100 << stats.team
    collision_mask = 0b0010 >> stats.team
