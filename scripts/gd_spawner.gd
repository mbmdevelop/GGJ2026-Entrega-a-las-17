extends Node2D
class_name EnemySpawner

@export var enemy_scene: PackedScene
@export var enemy_textures: Array[Texture2D]
@onready var enemy_timer: Timer = $enemy_timer
@onready var player_character = $"../PlayerCharacter"

@export var enemies_speed:float = 3.0
var enemies_prev_speed:float = enemies_speed

var can_be_invul:bool = true

func _ready():
	enemies_prev_speed = enemies_speed

func _on_enemy_timer_timeout() -> void:
	var x_viewport = get_viewport().size.x
	var y_viewport = get_viewport().size.y
	var position_spawners:Array[Vector2]
	position_spawners = [Vector2(0.0,0.0), Vector2(0.0, y_viewport), Vector2(x_viewport, 0.0), Vector2(x_viewport, y_viewport)]
	
	var enemy:Enemy = enemy_scene.instantiate() as Enemy
	enemy.global_position = position_spawners.pick_random()
	enemy.init(player_character, enemy_textures.pick_random(), enemies_speed, can_be_invul)
	add_child(enemy)

func change_all_enemies_vul(new_value:bool):
	for enemy in get_children():
		var current_enemy:Enemy = enemy as Enemy
		if current_enemy:
			current_enemy.set_invul(new_value)
			can_be_invul = new_value

func change_all_enemies_speed(new_speed:float):
	for enemy in get_children():
		var current_enemy:Enemy = enemy as Enemy
		if current_enemy:
			current_enemy.move_speed = new_speed
			enemies_speed = new_speed

func restore_enemies(mask_type: int):
	match mask_type:
		0:
			can_be_invul = true
		1:
			change_all_enemies_speed(enemies_prev_speed)
