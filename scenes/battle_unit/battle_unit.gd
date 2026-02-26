extends Area2D
class_name BattleUnit


@export var stats: UnitStats: set = _set_stats


@onready var skin: PackedSprite2D = $Skin
@onready var health_bar: ProgressBar = $HealthBar
@onready var mana_bar: ProgressBar = $ManaBar
@onready var tier_icon: TierIcon = $TierIcon

@onready var detect_range: DetectRange = $DetectRange
@onready var hurt_box: HurtBox = $HurtBox

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var unit_ai: UnitAI = $UnitAI
@onready var target_finder: TargetFinder = $TargetFinder
@onready var flip_sprite: FlipSprite = $FlipSprite
@onready var melee_attack: Attack = $MeleeAttack
@onready var attack_timer: Timer = $AttackTimer


func _ready() -> void:
  hurt_box.hurt.connect(_on_hurt)


func _set_stats(value: UnitStats) -> void:
  stats = value
  if not stats or not is_node_ready(): return

  stats = value.duplicate()
  collision_layer = stats.get_collision_layer()
  hurt_box.collision_layer = stats.get_collision_layer()
  hurt_box.collision_mask = stats.get_collision_mask()

  melee_attack.spawner.scene = stats.melee_attack

  skin.texture = UnitStats.TEAM_SPRITESHEET[stats.team]
  skin.coordinates = stats.skin_coordinates
  skin.flip_h = stats.is_player()
  health_bar.stats = stats
  mana_bar.stats = stats
  tier_icon.stats = stats
  detect_range.stats = stats
  stats.health_reached_zero.connect(queue_free)


func _on_hurt(damage: int) -> void:
  stats.health -= damage
