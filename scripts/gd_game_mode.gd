extends Node

#Waves
@export var waves_times:Array[float]
@onready var wave_timer: Timer = $WaveTimer
@onready var current_wave_lable: Label = $"../CanvasLayer/Hud/CurrentWaveLable"
var current_wave_num:int = 0

#UI
@onready var hud: Hud = $"../CanvasLayer/Hud"
@onready var progress_bar: ProgressBar = $"../CanvasLayer/Hud/ProgressBar"

#Misc
@onready var player_character: CharacterBody2D = $"../PlayerCharacter"
@export var main_menu_scene: PackedScene

func set_player_character_initial_position():
	var screen_middle_point: Vector2 = get_viewport().size * 0.5
	player_character.global_position = screen_middle_point
	
func _ready() -> void:
	set_player_character_initial_position()
	
	start_next_dialogue()

func _process(_delta: float) -> void:
	hud.set_countdowntime(wave_timer.time_left)

func start_next_wave(stop_dialogue:bool):
	if stop_dialogue:
		get_tree().set('paused', false)
	
	if current_wave_num == waves_times.size():
		return_to_main_menu()
		return
	
	hud.set_currentwave(current_wave_num + 1)
	wave_timer.wait_time = waves_times[current_wave_num]
	wave_timer.set_one_shot(true)
	wave_timer.start()
	
	current_wave_num += 1

func start_next_dialogue():
	var is_final_dialogue:bool = current_wave_num == waves_times.size()
	var next_dialogue_str = "res://timelines/tm_outro.dtl" if is_final_dialogue else "res://timelines/tm_oleada" + str(current_wave_num) + ".dtl"

	Dialogic.start(next_dialogue_str).process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.timeline_ended.connect(start_next_wave.bind(true))
	
	get_tree().paused = true

func _on_wave_timer_timeout() -> void:
	progress_bar.value = progress_bar.value - 20
	start_next_dialogue()

func return_to_main_menu():
	get_tree().change_scene_to_packed(main_menu_scene)
