extends Control
class_name Hud

@onready var count_down_label: Label = $CountDownLabel
@onready var current_wave_lable: Label = $CurrentWaveLable

func set_countdowntime(new_time: float):
	var minutes: int = floor(int(new_time) / 60.0)
	var seconds: int = int(new_time) - minutes * 60
	var time_string: String = "%02d:%02d" % [minutes, seconds]
	count_down_label.set_text(time_string)

func set_currentwave(num_wave: int):
	var wave_string: String = "Wave: %d" % [num_wave+1]
	current_wave_lable.set_text(wave_string)

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
