extends Button

func _ready() -> void:
	pressed.connect(_exit_game)

func _exit_game():
	get_tree().quit()
