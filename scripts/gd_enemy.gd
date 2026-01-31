extends CharacterBody2D
class_name Enemy

@export var move_speed:int

var player_character:CharacterBody2D = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if player_character:
		var target_direction: Vector2 = (player_character.global_position - global_position).normalized()
		position += target_direction * 3.0
	move_and_slide()
