extends TextureButton

signal mask_clicked_signal(mask_type)

enum MaskType {mask1, mask2, mask3}
@export var mask_type:MaskType = MaskType.mask1
	
func _on_pressed() -> void:
	mask_clicked_signal.emit(mask_type)
	print(mask_type)
