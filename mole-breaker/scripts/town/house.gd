extends Area2D

@onready var sprite: Sprite2D = $Sprite
@onready var red_alert: Sprite2D = $RedAlert
@onready var info_popup: HelpDialogPopup = $CanvasLayer/InfoPopup
@onready var closed_sound: AudioStreamPlayer = $ClosedSound
@onready var building_click_sound: AudioStreamPlayer = $BuildingClickSound
@onready var inventory_popup: InventoryPopup = $CanvasLayer/InventoryPopup

var isLocked : bool = true

signal on_click()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	info_popup.set_text(GameConstants.TOWN_INFO_HOUSE)
	ExperienceBus.level_increased.connect(check_lock_status)
	check_lock_status(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func check_lock_status(_value : int) -> void:
	var buildings = PlayerStats.unlockedBuildings
	
	if PlayerStats.unlockedBuildings.any(func(number): return number == GameConstants.BuildingType.HOUSE):
		isLocked = false
		sprite.modulate = Color(1,1,1,1)
		red_alert.visible = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_released():
		building_click_sound.play()
		
		if isLocked:
			#show info
			info_popup.visible = true
		else:
			inventory_popup.visible = true


func _on_info_popup_on_close() -> void:
	closed_sound.play()
	info_popup.visible = false


func _on_overlay_shadow_on_close() -> void:
	closed_sound.play()
	inventory_popup.visible = false
