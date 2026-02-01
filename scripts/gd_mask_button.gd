extends TextureButton
class_name MaskButton

signal mask_clicked_signal(mask_type:int)

enum MaskType {mask1, mask2, mask3}
@export var mask_type:MaskType = MaskType.mask1

func _on_pressed() -> void:
	mask_clicked_signal.emit(mask_type)
