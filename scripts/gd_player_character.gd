extends CharacterBody2D

@export_group("Speeds")
## Move speed
@export var move_speed:float = 10.0

@export_group("Misc")
@export var target_dist_threshold:float = 5.0

@onready var grenade_socket:Node2D = $GrenadeSocket
@onready var grenade_sc = preload("res://scenes/sc_grenade.tscn")
var grenade_instance:Grenade = null

var target_position:Vector2 = Vector2.ZERO

func spawn_grenade():
	grenade_instance = grenade_sc.instantiate() as Grenade
	grenade_socket.add_child(grenade_instance)

func _ready():
	var screen_middle_point:Vector2 = get_viewport().size * 0.5
	position = screen_middle_point
	target_position = screen_middle_point
	
	spawn_grenade()


func _input(event):
	if event.is_action_pressed("left_click"):
		var is_grenade_clicked:bool = grenade_instance.is_mouse_ontop()
		if is_grenade_clicked:
			grenade_instance.is_attached_to_mouse = true
		else:
			target_position = get_global_mouse_position()
	if event.is_action_released("left_click"):
		var is_grenade_clicked:bool = grenade_instance.is_mouse_ontop()
		if grenade_instance.is_attached_to_mouse:
			grenade_instance.is_attached_to_mouse = false
			grenade_instance.throw()

func _physics_process(delta: float) -> void:
	if position.distance_to(target_position) > target_dist_threshold:
		var target_dir:Vector2 = (target_position-position).normalized()
		position += target_dir * move_speed
	move_and_slide()
