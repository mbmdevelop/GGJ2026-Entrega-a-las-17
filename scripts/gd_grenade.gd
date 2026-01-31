extends Node2D
class_name Grenade

signal destroy_signal

@onready var grenade_explosion_sc = preload("res://scenes/sc_grenade_explosion.tscn")
@onready var collision_shape:CollisionShape2D = $Sprite2D/Area2D/CollisionShape2D

var is_attached_to_mouse:bool = false
var last_frame_position:Vector2 = Vector2.ZERO
var throw_velocity:Vector2 = Vector2.ZERO
var test:bool = false

func _ready():
	collision_shape.disabled = true

func _process(delta: float) -> void:
	if is_grenade_oob():
		destroy_signal.emit()
		return
		
	last_frame_position = global_position
	if is_attached_to_mouse:
		global_position = get_global_mouse_position()
	else:
		if test:
			position += throw_velocity

func is_grenade_oob()->bool:
	var screen_size:Vector2 = get_viewport().size
	return global_position.x <= 0.0 || global_position.x >= screen_size.x || global_position.y >= screen_size.y || global_position.y <= 0.0

func throw():
	reparent(get_tree().get_root())
	collision_shape.disabled = false
	throw_velocity = (global_position - last_frame_position).normalized() * 10.0
	test = true

func is_mouse_ontop() -> bool:
	var collision_shape_size:Vector2 = collision_shape.shape.get_rect().size
	var left:float = global_position.x - (collision_shape_size.x * 0.5)
	var right:float = global_position.x + (collision_shape_size.x * 0.5)
	var top:float = global_position.y - (collision_shape_size.y * 0.5)
	var bot:float = global_position.y + (collision_shape_size.y * 0.5)
	
	var mouse_position:Vector2 = get_global_mouse_position()
	
	return mouse_position.x >= left && mouse_position.x <= right && mouse_position.y >= top && mouse_position.y <= bot

func _on_area_2d_body_entered(body: Node2D) -> void:
	var grenade_explosion = grenade_explosion_sc.instantiate()
	get_tree().root.add_child(grenade_explosion)
	grenade_explosion.global_position = global_position
	
	destroy_signal.emit()
