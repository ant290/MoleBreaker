extends ColorRect
class_name SettingsPopup

signal on_close()

@onready var useCrtCheckButton : CheckButton = $SettingsPopup/SettingsVertContainer/UseCRTCheckButton
@onready var masterVolume: SettingsVolume = $SettingsPopup/SettingsVertContainer/MasterVolume
@onready var musicVolume: SettingsVolume = $SettingsPopup/SettingsVertContainer/MusicVolume
@onready var effectsVolume: SettingsVolume = $SettingsPopup/SettingsVertContainer/EffectsVolume
@onready var soundEffectsSample: AudioStreamPlayer = $SoundEffectsSample


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#useCrtCheckButton.button_pressed = Settings.useCrtShader
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_button_pressed() -> void:
	GameSaveService.save_game()
	on_close.emit()

func _on_use_crt_check_button_toggled(toggled_on: bool) -> void:
	Settings.set_use_crt(toggled_on)

func _on_master_volume_volume_drag_ended(value: float) -> void:
	Settings.set_master_volume(value)

func _on_master_volume_volume_drag_changed(value: float) -> void:
	Settings.set_master_volume(value)

func _on_music_volume_volume_drag_ended(value: float) -> void:
	Settings.set_music_volume(value)

func _on_music_volume_volume_drag_changed(value: float) -> void:
	Settings.set_music_volume(value)

func _on_effects_volume_volume_drag_ended(value: float) -> void:
	Settings.set_effects_volume(value)
	soundEffectsSample.play()

func _on_visibility_changed() -> void:
	if useCrtCheckButton != null:
		useCrtCheckButton.button_pressed = Settings.useCrtShader
	
	if masterVolume != null:
		masterVolume.set_slider_value(Settings.volumeMaster)

	if musicVolume != null:
		musicVolume.set_slider_value(Settings.volumeMusic)
	
	if effectsVolume != null:
		effectsVolume.set_slider_value(Settings.volumeEffects)
