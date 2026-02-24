@tool
extends Area2D
class_name Unit


signal quick_sell_pressed


@export var stats: UnitStats: set = set_stats


@onready var skin: PackedSprite2D = $Visuals/Skin
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var mana_bar: ProgressBar = $ManaBar
@onready var tier_icon: TierIcon = $TierIcon

@onready var drag_and_drop: DragAndDrop = $DragAndDrop
@onready var velocity_based_rotation: VelocityBasedRotation = $VelocityBasedRotation
@onready var outline_highlighter: OutlineHighlighter = $OutlineHighlighter
@onready var animations: UnitAnimations = $UnitAnimations


var is_hovered := false


func _ready() -> void:
  if Engine.is_editor_hint(): return
  drag_and_drop.drag_started.connect(_on_drag_started)
  drag_and_drop.drag_canceled.connect(_on_drag_canceled)


func _input(event: InputEvent) -> void:
  if not is_hovered: return
  if event.is_action_pressed("quick_sell"):
    quick_sell_pressed.emit()


func set_stats(new_stats: UnitStats) -> void:
  if not Engine.is_editor_hint():
    stats = new_stats.duplicate()
  else:
    stats = new_stats
  if stats == null or not is_node_ready(): return
  skin.coordinates = stats.skin_coordinates
  tier_icon.stats = stats


func reset_after_dragging(starting_position: Vector2) -> void:
  velocity_based_rotation.enabled = false
  global_position = starting_position


func _on_mouse_entered() -> void:
  if drag_and_drop.dragging: return
  outline_highlighter.highlight()
  z_index = 2
  is_hovered = true


func _on_mouse_exited() -> void:
  if drag_and_drop.dragging: return
  outline_highlighter.clear_highlight()
  z_index = 0
  is_hovered = false


func _on_drag_started() -> void:
  velocity_based_rotation.enabled = true


func _on_drag_canceled(starting_position: Vector2) -> void:
  reset_after_dragging(starting_position)
