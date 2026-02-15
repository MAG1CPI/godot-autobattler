extends Node2D
class_name Arena


const CELL_SIZE := Vector2(32, 32)
const HALF_CELL_SIZE := CELL_SIZE / 2
const QUARTER_CELL_SIZE := HALF_CELL_SIZE / 2


@onready var visuals: Node2D = $Visuals
@onready var game_area: PlayArea = $GameArea
@onready var bench: PlayArea = $Bench
@onready var unit_mover: UnitMover = $UnitMover
@onready var unit_spawner: UnitSpawner = $UnitSpawner
@onready var sell_portal: SellPortal = $SellPortal
@onready var shop: Shop = $UILayer/Shop


func _ready() -> void:
  unit_spawner.unit_spawned.connect(unit_mover.setup_unit)
  unit_spawner.unit_spawned.connect(sell_portal.setup_unit)
  shop.unit_bought.connect(unit_spawner.spawn_unit)
