@icon("res://assets/icons/hitbox_icon.svg")
extends Area2D
class_name HitBox


signal hit()


@export var damage: int


func _ready() -> void:
  area_entered.connect(_on_area_entered)


func _on_area_entered(hurt_box: Area2D) -> void:
  if not hurt_box is HurtBox: return
  hit.emit()
