extends PanelContainer
class_name TraitUI


@export var trait_data: Trait: set = _set_trait_data
@export var active: bool: set = _set_active


@onready var trait_icon: TextureRect = %TraitIcon
@onready var active_units_label: Label = %ActiveUnitsLabel
@onready var trait_level_labels: RichTextLabel = %TraitLevelLabels
@onready var trait_label: Label = %TraitLabel


func update(units: Array[Unit]) -> void:
  var unique_units := trait_data.get_unique_unit_count(units)
  active_units_label.text = str(unique_units)
  trait_level_labels.text = trait_data.get_levels_bbcode(unique_units)
  active = trait_data.is_active(unique_units)


func _set_trait_data(new_trait_data: Trait) -> void:
  trait_data = new_trait_data
  if not is_node_ready(): return
  trait_icon.texture = trait_data.icon
  trait_label.text = trait_data.name


func _set_active(flag: bool) -> void:
  active = flag
  modulate.a = 1.0 if active else 0.5
