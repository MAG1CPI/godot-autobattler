extends Node
class_name VelocityBasedRotation


@export var enabled: bool = true: set = _set_enabled
@export var target: Node2D: set = _set_target
@export_range(0.25, 1.5) var lerp_seconds := 0.4
@export var max_rotation_degree := 60.0
@export var x_velocity_threshold := 50.0


var last_postion: Vector2
var velocity: Vector2
var progress: float
var time_elapsed: float
var start_angle: float
var target_angle: float
var rotating: bool = false


func _physics_process(delta: float) -> void:
  if not enabled or not target: return
  
  velocity = (target.global_position - last_postion) / delta
  last_postion = target.global_position

  var new_angle: float = 0.0
  if abs(velocity.x) >= x_velocity_threshold:
    new_angle = velocity.normalized().x * deg_to_rad(max_rotation_degree)
  
  if not rotating or not is_equal_approx(new_angle, target_angle):
    rotating = true
    start_angle = target.rotation
    target_angle = new_angle
    time_elapsed = 0.0

  if rotating:
    time_elapsed += delta
    progress = time_elapsed / lerp_seconds
    if progress >= 1.0:
      rotating = false
      target.rotation = target_angle
    else:
      target.rotation = lerp_angle(start_angle, target_angle, progress)


func _set_enabled(new_flag: bool) -> void:
  enabled = new_flag
  if target and not enabled:
    target.rotation = 0.0
    time_elapsed = 0.0
    rotating = false


func _set_target(new_target: Node2D) -> void:
  target = new_target
  if target:
    last_postion = target.global_position
