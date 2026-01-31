extends Node

@export var waves_times:Array[float]

@onready var wave_timer: Timer = $WaveTimer
@onready var hud: Hud = $"../Hud"
@onready var current_wave_lable: Label = $"../Hud/CurrentWaveLable"

var current_wave_num:int = 0

func _ready() -> void:
	wave_timer.wait_time = waves_times[current_wave_num]
	wave_timer.set_one_shot(true)
	wave_timer.start()

func _process(_delta: float) -> void:
	print(wave_timer.time_left)
	hud.set_countdowntime(wave_timer.time_left)
	hud.set_currentwave(current_wave_num)
	if wave_timer.is_stopped():
		current_wave_num += 1
		wave_timer.wait_time = waves_times[current_wave_num]
		wave_timer.start()
