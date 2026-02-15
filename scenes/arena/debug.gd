extends Node

@onready var root: Arena = $"../"
@onready var visuals: Node2D = $"../Visuals"
@onready var game_area: PlayArea = $"../GameArea"
@onready var bench: PlayArea = $"../Bench"
@onready var unit_mover: UnitMover = $"../UnitMover"

var inc := 0.0;


#func _process(delta: float) -> void:
  #inc += delta
  #inc = 0.0 if inc > 0.1 else inc
  #if inc == 0:
    #print(unit_mover._get_play_area_for_position(root.get_global_mouse_position()))


#func _input(event: InputEvent) -> void:
  #if event.is_action_pressed("ui_accept"):
    #var units := get_tree().get_nodes_in_group("units")
    #units[1].animations.play_combine_animation(units[0].global_position + Arena.QUARTER_CELL_SIZE)
    #units[2].animations.play_combine_animation(units[0].global_position + Arena.QUARTER_CELL_SIZE)

    #root.unit_combiner.queue_unit_combination_update()
