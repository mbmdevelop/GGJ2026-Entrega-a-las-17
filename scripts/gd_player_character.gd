extends CharacterBody2D
class_name PlayerCharacter

signal player_die_signal

@export_group("Params")
@export var move_speed:float = 10.0
@export var target_dist_threshold:float = 5.0
@export var spawn_grenade_time:float = 1.0
@export var hp:int = 3

@onready var grenade_socket:Node2D = $GrenadeSocketRight
@onready var grenade_sc = preload("res://scenes/sc_grenade.tscn")
@onready var spawn_grenade_timer:Timer = $SpawnGrenadeTimer
var grenade_instance:Grenade = null
var target_position:Vector2 = Vector2.ZERO

func spawn_grenade():
	if grenade_instance:
		return
	grenade_instance = grenade_sc.instantiate() as Grenade
	grenade_instance.destroy_signal.connect(despawn_grenade)
	grenade_socket.add_child(grenade_instance)

func despawn_grenade():
	grenade_instance.queue_free()
	spawn_grenade_timer.wait_time = spawn_grenade_time
	spawn_grenade_timer.start()

func _ready():
	target_position = global_position
	
	spawn_grenade()

func _input(event):
	var is_grenade_clicked:bool = false
	if event.is_action_pressed("left_click"):
		if grenade_instance:
			is_grenade_clicked = grenade_instance.is_mouse_ontop()
		if is_grenade_clicked:
			grenade_instance.is_attached_to_mouse = true
		else:
			target_position = get_global_mouse_position()
	if event.is_action_released("left_click"):
		if grenade_instance:
			if grenade_instance.is_attached_to_mouse:
				grenade_instance.is_attached_to_mouse = false
				grenade_instance.throw()

func _physics_process(delta: float) -> void:
	if position.distance_to(target_position) > target_dist_threshold:
		var target_dir:Vector2 = (target_position-position).normalized()
		position += target_dir * move_speed
	move_and_slide()

func is_grenade_oob()->bool:
	if !grenade_instance:
		return false
	var screen_size:Vector2 = get_viewport().size
	return grenade_instance.global_position.x <= 0.0 || grenade_instance.global_position.x >= screen_size.x || grenade_instance.global_position.y >= screen_size.y || grenade_instance.global_position.y <= 0.0

func _on_spawn_grenade_timer_timeout() -> void:
	spawn_grenade()


func _on_enemy_hit_area_body_entered(body: Node2D) -> void:
	body.queue_free()
	
	hp -= 1
	if hp <=0:
		player_die_signal.emit()
