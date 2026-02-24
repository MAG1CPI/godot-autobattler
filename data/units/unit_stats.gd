extends Resource
class_name UnitStats


enum Rarity {COMMON, UNCOMMON, RARE, LEGENDARY}
enum Team {PLAYER, ENEMY}


const RARITY_COLORS := {
  Rarity.COMMON: Color("124a2e"),
  Rarity.UNCOMMON: Color("1c527c"),
  Rarity.RARE: Color("ab0979"),
  Rarity.LEGENDARY: Color("ea940b"),
}
const TEAM_SPRITESHEET := {
  Team.PLAYER: preload("uid://cx1ivjobggp8n"),
  Team.ENEMY: preload("uid://ct4xk88g67xlv"),
}


@export var name: String

@export_category("Data")
@export var rarity: Rarity
@export var gold_cost: int
@export_range(1, 3) var tier := 1: set = _set_tier
@export var traits: Array[Trait]
@export var pool_count := 9

@export_category("Visuals")
@export var skin_coordinates: Vector2i

@export_category("Battle")
@export var team: Team


func get_combined_unit_count() -> int:
  return 3 ** (tier - 1)


func get_combined_unit_gold_multiplier() -> int:
  if rarity == Rarity.COMMON:
    return 3 ** (tier - 1)
  return 6 if tier == 3 else tier


func get_gold_value() -> int:
  return gold_cost * get_combined_unit_gold_multiplier()


func _set_tier(new_tier: int) -> void:
  tier = new_tier
  emit_changed()


func _to_string() -> String:
  return name
