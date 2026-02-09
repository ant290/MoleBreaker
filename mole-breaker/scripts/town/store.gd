extends Area2D

signal on_click()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_released():
		on_click.emit()
