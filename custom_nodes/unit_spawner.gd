extends Node
class_name UnitSpawner


signal unit_spawned(unit: Unit)


@export var bench: PlayArea
@export var game_area: PlayArea


@onready var scene_spawner: SceneSpawner = $SceneSpawner


func _get_first_avilable_area() -> PlayArea:
  return bench if not bench.unit_grid.is_grid_full() \
    else game_area if not game_area.unit_grid.is_grid_full() \
    else null


func spawn_unit(stats: UnitStats) -> void:
  var area := _get_first_avilable_area()
  assert(area, "NO AVAILABLE SPACE TO ADD UNIT TO!") # TODO
  var new_unit := scene_spawner.spawn_scene(area.unit_grid) as Unit
  var tile := area.unit_grid.get_first_empty_tile()
  area.unit_grid.add_unit(tile, new_unit)
  new_unit.global_position = area.get_global_from_tile(tile) - Arena.HALF_CELL_SIZE
  new_unit.stats = stats
  unit_spawned.emit(new_unit)
