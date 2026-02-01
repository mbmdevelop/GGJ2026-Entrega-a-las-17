extends Control
class_name Hud

@onready var count_down_label: Label = $CountDownLabel
@onready var current_wave_lable: Label = $CurrentWaveLable

#Masks
@onready var mask_1: MaskButton = $Mask1
@onready var mask_2: MaskButton = $Mask2
@onready var mask_3: MaskButton = $Mask3

func set_countdowntime(new_time: float):
	var minutes: int = floor(int(new_time) / 60.0)
	var seconds: int = int(new_time) - minutes * 60
	var time_string: String = "%02d:%02d" % [minutes, seconds]
	count_down_label.set_text(time_string)

func set_currentwave(num_wave: int):
	var wave_string: String = "Wave: %d" % [num_wave]
	current_wave_lable.set_text(wave_string)

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_masks_darkened_enabled(new_value:bool):
	if new_value:
		var mask_1_new_color = mask_1.self_modulate.darkened(0.75)
		mask_1.self_modulate = mask_1_new_color
	
		var mask_2_new_color = mask_2.self_modulate.darkened(0.75)
		mask_2.self_modulate = mask_2_new_color
	
		var mask_3_new_color = mask_3.self_modulate.darkened(0.75)
		mask_3.self_modulate = mask_3_new_color
	else:
		var mask_1_new_color = mask_1.self_modulate.lightened(0.75)
		mask_1.self_modulate = mask_1_new_color
	
		var mask_2_new_color = mask_2.self_modulate.lightened(0.75)
		mask_2.self_modulate = mask_2_new_color
	
		var mask_3_new_color = mask_3.self_modulate.lightened(0.75)
		mask_3.self_modulate = mask_3_new_color
