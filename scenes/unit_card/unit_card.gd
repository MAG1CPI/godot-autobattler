extends Button
class_name UnitCard


signal unit_bought(unit: UnitStats)


const HOVER_BORDER_COLOR := Color("FAFA82")


@export var player_stats: PlayerStats
@export var unit_stats: UnitStats: set = _set_unit_stats


@onready var traits: Label = %Traits
@onready var bottom: Panel = %Bottom
@onready var unit_name: Label = %UnitName
@onready var cost_label: Label = %CostLabel
@onready var border: Panel = %Border
@onready var unit_icon: TextureRect = %UnitIcon
@onready var empty_placeholder: Panel = %EmptyPlaceholder

@onready var border_sb: StyleBoxFlat = border.get_theme_stylebox("panel")
@onready var bottom_sb: StyleBoxFlat = bottom.get_theme_stylebox("panel")


var bought := false
var border_color: Color


func _ready() -> void:
  player_stats.changed.connect(on_player_stats_changed)
  on_player_stats_changed()


func _set_unit_stats(new_unit_stats: UnitStats) -> void:
  unit_stats = new_unit_stats
  if not is_node_ready():
    await ready
  if not unit_stats:
    disabled = true
    _set_bought()
    return
  border_color = UnitStats.RARITY_COLORS[unit_stats.rarity]
  border_sb.border_color = border_color
  bottom_sb.bg_color = border_color
  traits.text = "\n".join(Trait.get_trait_names(unit_stats.traits))
  unit_name.text = unit_stats.name
  cost_label.text = str(unit_stats.gold_cost)
  unit_icon.texture.region.position = Vector2(unit_stats.skin_coordinates) * Arena.CELL_SIZE


func _set_bought():
  empty_placeholder.show()
  bought = true


func on_player_stats_changed() -> void:
  if not unit_stats: return
  var has_enough_gold := player_stats.gold >= unit_stats.gold_cost
  disabled = not has_enough_gold
  if has_enough_gold or bought:
    modulate = Color(Color.WHITE, 1.0)
  else:
    modulate = Color(Color.WHITE, 0.5)


func _on_mouse_entered() -> void:
  if not disabled:
    border_sb.border_color = HOVER_BORDER_COLOR


func _on_mouse_exited() -> void:
    border_sb.border_color = border_color


func _on_pressed() -> void:
  if bought: return
  _set_bought()
  player_stats.gold -= unit_stats.gold_cost
  unit_bought.emit(unit_stats)
