extends Node

@onready var root: Arena = $"../"
@onready var visuals: Node2D = $"../Visuals"
@onready var game_area: PlayArea = $"../GameArea"
@onready var bench: PlayArea = $"../Bench"
@onready var unit_mover: UnitMover = $"../UnitMover"

var inc := 0.0;


func _process(delta: float) -> void:
  inc += delta
  inc = 0.0 if inc > 0.1 else inc
  if inc == 0:
    print(unit_mover._get_play_area_for_position(root.get_global_mouse_position()))
