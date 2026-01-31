extends CharacterBody2D
class_name Enemy

@export var move_speed:int

@onready var sprite:Sprite2D = $Sprite2D

var player_character:CharacterBody2D = null
var texture:Texture2D = null

func _ready():
	sprite.set_texture(texture)

func init(in_player_character:CharacterBody2D, in_texture:Texture2D, in_move_speed:float):
	player_character = in_player_character
	texture = in_texture
	move_speed = in_move_speed

func _physics_process(_delta: float) -> void:
	if player_character:
		var target_direction: Vector2 = (player_character.global_position - global_position).normalized()
		position += target_direction * 3.0
	move_and_slide()
