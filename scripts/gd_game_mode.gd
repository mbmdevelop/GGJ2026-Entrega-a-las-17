extends Node

@export var waves_times:Array[float]

@onready var wave_timer: Timer = $WaveTimer
@onready var hud: Hud = $"../CanvasLayer/Hud"

@onready var current_wave_lable: Label = $"../CanvasLayer/Hud/CurrentWaveLable"
@onready var progress_bar: ProgressBar = $"../CanvasLayer/Hud/ProgressBar"

@onready var player_character_sc = preload("res://scenes/sc_player_character.tscn")

var current_wave_num:int = 0
var player_character:CharacterBody2D = null

func spawn_player_character():
	player_character = player_character_sc.instantiate() as CharacterBody2D
	player_character.reparent(get_tree().get_root())
	var screen_middle_point: Vector2 = get_viewport().size * 0.5
	player_character.global_position = screen_middle_point
	
func _ready() -> void:
	spawn_player_character()
	
	wave_timer.wait_time = waves_times[current_wave_num]
	wave_timer.set_one_shot(true)
	wave_timer.start()

func _process(_delta: float) -> void:
	#print(wave_timer.time_left)
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
	progress_bar.value = progress_bar.value - 20
	Dialogic.start("res://timelines/tm_dialogo1.dtl").process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.timeline_ended.connect(start_next_wave.bind(true))
	get_tree().paused = true
