extends Button
class_name XPButton


@export var player_stats: PlayerStats
@export var xp_gain: int = 4
@export var gold_require: int = 4


@onready var vbox_container: VBoxContainer = $VBoxContainer
@onready var xp_label: Label = %XPLabel
@onready var gold_label: Label = %GoldLabel


func _ready() -> void:
  xp_label.text = "+%s XP" % xp_gain
  gold_label.text = str(gold_require)

  player_stats.changed.connect(_on_player_stats_changed)
  _on_player_stats_changed()


func _on_player_stats_changed() -> void:
  var has_enough_gold := player_stats.gold >= gold_require
  var level_10 := player_stats.level == 10
  disabled = not has_enough_gold or level_10
  if has_enough_gold and not level_10:
    vbox_container.modulate.a = 1.0
  else:
    vbox_container.modulate.a = 0.5


func _on_pressed() -> void:
  player_stats.gold -= gold_require
  player_stats.xp += xp_gain
