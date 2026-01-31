extends Node2D

@export var enemy_scene: PackedScene
@export var enemy_textures: Array[Texture2D]
@onready var enemy_timer: Timer = $enemy_timer
@onready var player_character = $"../PlayerCharacter"

func _on_enemy_timer_timeout() -> void:
	var x_viewport = get_viewport().size.x
	var y_viewport = get_viewport().size.y
	var position_spawners:Array[Vector2]
	position_spawners = [Vector2(0.0,0.0), Vector2(0.0, y_viewport), Vector2(x_viewport, 0.0), Vector2(x_viewport, y_viewport)]
	
	var enemy:Enemy = enemy_scene.instantiate() as Enemy
	enemy.global_position = position_spawners.pick_random()
	enemy.init(player_character, enemy_textures.pick_random(), 3.0)
	add_child(enemy)
