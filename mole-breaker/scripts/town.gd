extends Node2D

@onready var crtShader : CanvasLayer = $CRTShader

@onready var settings_popup: SettingsPopup = $CanvasLayer/SettingsPopup
@onready var quests_popup: ColorRect = $CanvasLayer/QuestsPopup
@onready var balls_popup: ColorRect = $CanvasLayer/BallsPopup

@onready var building_click_sound: AudioStreamPlayer = $BuildingClickSound
@onready var closed_sound: AudioStreamPlayer = $ClosedSound

var has_popup_showing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crtShader.visible = Settings.useCrtShader
	Settings.use_crt_changed.connect(_on_settings_use_crt_changed)
	SceneTransitions.fade_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_settings_use_crt_changed(value: bool) -> void:
	crtShader.visible = value

func _on_touch_screen_button_released() -> void:
	if (!has_popup_showing):
		SceneTransitions.fade_out()
		await SceneTransitions.fade_complete
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_settings_on_click() -> void:
	building_click_sound.play()
	settings_popup.visible = true
	has_popup_showing = true

func _on_settings_popup_on_close() -> void:
	closed_sound.play()
	settings_popup.visible = false
	has_popup_showing = false

func _on_tavern_on_click() -> void:
	building_click_sound.play()
	quests_popup.visible = true
	has_popup_showing = true

func _on_quests_popup_on_close() -> void:
	closed_sound.play()
	quests_popup.visible = false
	has_popup_showing = false

func _on_store_on_click() -> void:
	building_click_sound.play()
	balls_popup.visible = true
	has_popup_showing = true

func _on_balls_popup_on_close() -> void:
	closed_sound.play()
	balls_popup.visible = false
	has_popup_showing = false
