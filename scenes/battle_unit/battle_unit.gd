extends Area2D
class_name BattleUnit


@export var stats: UnitStats: set = set_stats


@onready var skin: PackedSprite2D = $Skin
@onready var health_bar: ProgressBar = $HealthBar
@onready var mana_bar: ProgressBar = $ManaBar
@onready var tier_icon: TierIcon = $TierIcon
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func set_stats(value: UnitStats) -> void:
  stats = value
  if not stats or not is_node_ready(): return

  stats = value.duplicate()
  collision_layer = 1 << stats.team

  skin.texture = UnitStats.TEAM_SPRITESHEET[stats.team]
  skin.coordinates = stats.skin_coordinates
  skin.flip_h = stats.team == stats.Team.PLAYER
  tier_icon.stats = stats
