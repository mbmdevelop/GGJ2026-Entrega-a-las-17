extends CharacterBody2D

@export var move_speed:int

var target_position:Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_position = get_viewport().size * 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var target_direction: Vector2 = (target_position - global_position).normalized()
	position += target_direction * move_speed
	move_and_slide()
	
