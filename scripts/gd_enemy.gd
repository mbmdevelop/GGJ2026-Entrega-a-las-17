extends CharacterBody2D
class_name Enemy


@onready var sprite:Sprite2D = $Sprite2D
var player_character:CharacterBody2D = null
var texture:Texture2D = null
var move_speed:float = 1.0
var is_invul:bool = false

func _ready():
	sprite.set_texture(texture)
	if is_invul:
		set_invul(true)

func init(in_player_character:CharacterBody2D, in_texture:Texture2D, in_move_speed:float):
	player_character = in_player_character
	texture = in_texture
	move_speed = in_move_speed
	
	var invul_rand_array:Array[int] = [0,1,2]
	var invul_rand_result = invul_rand_array.pick_random()
	#if invul_rand_result == 1:
	is_invul = true

func _physics_process(_delta: float) -> void:
	if player_character:
		var target_direction: Vector2 = (player_character.global_position - global_position).normalized()
		position += target_direction * move_speed
	move_and_slide()
	
func set_invul(new_value:bool):
	if new_value:
		sprite.self_modulate.a = 0.15
		set_collision_layer_value(4,false)
		set_collision_layer_value(5,true)
	else:
		sprite.self_modulate.a = 1
		set_collision_layer_value(4,true)
		set_collision_layer_value(5,false)
