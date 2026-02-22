extends Area2D

@onready var sprite: Sprite2D = $Sprite
@onready var red_alert: Sprite2D = $RedAlert
@onready var balls_popup: BallsPopup = $CanvasLayer/BallsPopup
@onready var info_popup: HelpDialogPopup = $CanvasLayer/InfoPopup
@onready var closed_sound: AudioStreamPlayer = $ClosedSound
@onready var building_click_sound: AudioStreamPlayer = $BuildingClickSound
@onready var lock_status: Label = $LockStatus

var isLocked : GameConstants.LockStatus = GameConstants.LockStatus.LOCKED
var buildingMapping : BuildingMapping

signal on_click()

func _ready() -> void:
	buildingMapping = GameObjects.BUILDING_DETAILS[GameConstants.BuildingType.STORE]
	info_popup.set_text(GameConstants.TOWN_INFO_STORE)
	check_lock_status()
	
func check_lock_status() -> void:
	if PlayerStats.unlockedBuildings.any(func(number): return number == GameConstants.BuildingType.STORE):
		isLocked = GameConstants.LockStatus.UNLOCKED
		sprite.modulate = Color(1,1,1,1)
		red_alert.visible = false
		lock_status.text = "Unlocked"
	else:
		if buildingMapping.level_requirement <= PlayerStats.currentLevel:
			isLocked = GameConstants.LockStatus.UNLOCKABLE
			lock_status.text = "Unlockable"
		else:
			isLocked = GameConstants.LockStatus.LOCKED
			lock_status.text = "Locked"

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_released():
		building_click_sound.play()
		
		match isLocked:
			GameConstants.LockStatus.LOCKED:
				info_popup.visible = true
			GameConstants.LockStatus.UNLOCKABLE:
				unlock_building()
			GameConstants.LockStatus.UNLOCKED:
				balls_popup.visible = true

func unlock_building() -> void:
	if buildingMapping == null:
		return
	if buildingMapping.level_requirement > PlayerStats.currentLevel:
		return
	
	if PlayerStats.can_afford(buildingMapping.brick_cost):
		#do unlock
		#todo: add confirm / cost modal
		PlayerStats.unlock_building(buildingMapping.building_type, buildingMapping.brick_cost)
		check_lock_status()

func _on_info_popup_on_close() -> void:
	closed_sound.play()
	info_popup.visible = false


func _on_balls_popup_on_close() -> void:
	closed_sound.play()
	balls_popup.visible = false
