@tool
extends Sprite2D
class_name PackedSprite2D

@export var coordinates: Vector2i:
  set(new_coordinates):
    coordinates = new_coordinates
    region_rect.position = Vector2(coordinates) * Arena.CELL_SIZE
