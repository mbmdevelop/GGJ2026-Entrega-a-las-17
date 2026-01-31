extends Node2D

@export var enemy_scene: PackedScene
@onready var enemy_timer: Timer = $enemy_timer
@onready var player_character = $"../PlayerCharacter"

func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate() as Enemy
	var x_viewport = get_viewport().size.x
	var y_viewport = get_viewport().size.y
	var position_spawners:Array[Vector2]
	position_spawners = [Vector2(0.0,0.0), Vector2(0.0, y_viewport), Vector2(x_viewport, 0.0), Vector2(x_viewport, y_viewport)]
	enemy.global_position = position_spawners.pick_random()
	enemy.player_character = player_character
	add_child(enemy)
