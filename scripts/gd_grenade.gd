extends Node2D
class_name Grenade

@onready var collision_shape:CollisionShape2D = $Sprite2D/Area2D/CollisionShape2D

var is_attached_to_mouse:bool = false
var last_frame_position:Vector2 = Vector2.ZERO
var throw_velocity:Vector2 = Vector2.ZERO
var test:bool = false

func _process(delta: float) -> void:
	last_frame_position = global_position
	if is_attached_to_mouse:
		global_position = get_global_mouse_position()
	else:
		if test:
			position += throw_velocity
	
	#move_and_slide()

func throw():
	throw_velocity = (global_position - last_frame_position).normalized() * 5
	test = true

func is_mouse_ontop() -> bool:
	var collision_shape_size:Vector2 = collision_shape.shape.get_rect().size
	var left:float = global_position.x - (collision_shape_size.x * 0.5)
	var right:float = global_position.x + (collision_shape_size.x * 0.5)
	var top:float = global_position.y - (collision_shape_size.y * 0.5)
	var bot:float = global_position.y + (collision_shape_size.y * 0.5)
	
	var mouse_position:Vector2 = get_global_mouse_position()
	
	return mouse_position.x >= left && mouse_position.x <= right && mouse_position.y >= top && mouse_position.y <= bot
