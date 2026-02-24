extends VBoxContainer
class_name Shop


signal unit_bought(unit_stats: UnitStats)


@export var player_stats: PlayerStats
@export var unit_pool: UnitPool


@onready var shop_cards: VBoxContainer = %ShopCards
@onready var scene_spawner: SceneSpawner = $SceneSpawner


func _ready() -> void:
  unit_pool.generate_unit_pool()

  for unit_card: UnitCard in shop_cards.get_children():
    unit_card.queue_free()

  _roll_units()


func _roll_units() -> void:
  for i in 5:
    var rarity := player_stats.get_random_rarity_for_level()
    var new_card := scene_spawner.spawn_scene(shop_cards) as UnitCard # FIXME: IF NOT ENOUGH UNITS FOR CERTAIN RARITY
    new_card.unit_stats = unit_pool.get_random_unit_by_ratity(rarity)
    new_card.unit_bought.connect(_on_unit_bought)


func _put_back_remaining_to_pool() -> void:
  for unit_card: UnitCard in shop_cards.get_children():
    if not unit_card.bought:
      unit_pool.add_unit(unit_card.unit_stats)
    unit_card.queue_free()


func _on_unit_bought(stats: UnitStats) -> void:
  unit_bought.emit(stats)


func _on_reroll_button_pressed() -> void:
  _put_back_remaining_to_pool()
  _roll_units()
