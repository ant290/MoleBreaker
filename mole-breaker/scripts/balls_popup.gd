extends ColorRect
class_name BallsPopup

signal on_close()

func _on_close_button_pressed() -> void:
	on_close.emit()
