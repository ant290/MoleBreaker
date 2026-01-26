extends ColorRect
class_name SettingsPopup

signal on_close()

@onready var useCrtCheckButton : CheckButton = $SettingsPopup/UseCRTCheckButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	useCrtCheckButton.button_pressed = Settings.useCrtShader

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_button_pressed() -> void:
	GameSaveService.save_game()
	on_close.emit()

func _on_use_crt_check_button_toggled(toggled_on: bool) -> void:
	Settings.set_use_crt(toggled_on)


func _on_visibility_changed() -> void:
	if useCrtCheckButton != null:
		useCrtCheckButton.button_pressed = Settings.useCrtShader
