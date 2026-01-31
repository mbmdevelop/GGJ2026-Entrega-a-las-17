extends Button

@export var game_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_play_game, 4)

func _play_game():
	get_tree().change_scene_to_packed(game_scene)
