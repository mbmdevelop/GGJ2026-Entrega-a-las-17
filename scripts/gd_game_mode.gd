extends Node

@export var waves_times:Array[float]

@onready var wave_timer: Timer = $WaveTimer
@onready var spawn_timer: Timer = $SpawnTimer
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


func start_next_wave(stop_dialogue:bool):
	current_wave_num += 1
	if current_wave_num >= waves_times.size():
		return
	if stop_dialogue:
		get_tree().set('paused', false)
	wave_timer.wait_time = waves_times[current_wave_num]
	wave_timer.start()
		
func _on_wave_timer_timeout() -> void:
	Dialogic.start("res://timelines/tm_dialogo1.dtl").process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.timeline_ended.connect(start_next_wave.bind(true))
	get_tree().paused = true
