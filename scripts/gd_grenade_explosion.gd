extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_life_time_timer_timeout() -> void:
	queue_free()
