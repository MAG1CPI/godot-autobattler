@tool
extends Area2D
class_name Unit

@export var stats: UnitStats: set = set_stats

@onready var skin: Sprite2D = $Skin
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var mana_bar: ProgressBar = $ManaBar

func set_stats(new_stats: UnitStats) -> void:
  stats = new_stats
  if stats == null: return
  if not is_node_ready(): await ready
  skin.region_rect.position = Vector2(stats.skin_coordinates) * Arena.CELL_SIZE
