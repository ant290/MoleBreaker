extends Control

@onready var settingsPopup : ColorRect = $SettingsPopup
@onready var crtShader : CanvasLayer = $CRTShader
@onready var buttonClickSound: AudioStreamPlayer = $ButtonClickSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameSaveService.load_game()
	crtShader.visible = Settings.useCrtShader
	Settings.use_crt_changed.connect(_on_settings_use_crt_changed)
	AmbientMusic.play_ambient_music(AmbientMusicPlayer.MUSIC_NAME_CABIN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_settings_use_crt_changed(value: bool) -> void:
	crtShader.visible = value

func _on_play_button_pressed() -> void:
	buttonClickSound.play()
	SceneTransitions.fade_out("Breaker")
	await SceneTransitions.fade_complete
	
	get_tree().change_scene_to_file("res://scenes/brickBreaker/level.tscn")

func _on_town_button_pressed() -> void:
	buttonClickSound.play()
	SceneTransitions.fade_out()
	await SceneTransitions.fade_complete
	
	get_tree().change_scene_to_file("res://scenes/town/town.tscn")

func _on_quit_button_pressed() -> void:
	buttonClickSound.play()
	SceneTransitions.fade_out()
	await SceneTransitions.fade_complete
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	buttonClickSound.play()
	settingsPopup.visible = true

func _on_settings_popup_on_close() -> void:
	settingsPopup.visible = false
