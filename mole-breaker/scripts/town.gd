extends Node2D

@onready var crtShader : CanvasLayer = $CRTShader

@onready var inventory : InventoryPopup = $CanvasLayer/Inventory
@onready var settings_popup: SettingsPopup = $CanvasLayer/SettingsPopup
@onready var quests_popup: ColorRect = $CanvasLayer/QuestsPopup

@onready var building_click_sound: AudioStreamPlayer = $BuildingClickSound
@onready var closed_sound: AudioStreamPlayer = $ClosedSound


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
	SceneTransitions.fade_out()
	await SceneTransitions.fade_complete
	
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_house_on_click() -> void:
	building_click_sound.play()
	inventory.visible = true

func _on_inventory_on_close() -> void:
	closed_sound.play()
	inventory.visible = false

func _on_settings_on_click() -> void:
	building_click_sound.play()
	settings_popup.visible = true

func _on_settings_popup_on_close() -> void:
	closed_sound.play()
	settings_popup.visible = false

func _on_tavern_on_click() -> void:
	building_click_sound.play()
	quests_popup.visible = true

func _on_quests_popup_on_close() -> void:
	closed_sound.play()
	quests_popup.visible = false
