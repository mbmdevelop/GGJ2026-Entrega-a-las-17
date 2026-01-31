extends Node2D

@export var enemy_scene: PackedScene
@onready var enemy_timer: Timer = $enemy_timer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	var x_viewport = get_viewport().size.x
	var y_viewport = get_viewport().size.y
	var position_spawners:Array[Vector2]
	position_spawners = [Vector2(0.0,0.0), Vector2(0.0, y_viewport), Vector2(x_viewport, 0.0), Vector2(x_viewport, y_viewport)]
	enemy.global_position = position_spawners.pick_random()
	print(enemy.global_position)
	add_child(enemy)
