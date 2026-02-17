extends ColorRect
class_name HelpDialogPopup

@onready var rich_text_label: RichTextLabel = $UiPopup/RichTextLabel

signal on_close()

func _on_close_button_pressed() -> void:
	on_close.emit()

func set_text(text: String) -> void:
	rich_text_label.text = text
