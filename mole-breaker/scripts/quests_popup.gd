extends ColorRect
class_name QuestsPopup

@onready var quest_heading_scene = preload("res://scenes/quest_heading.tscn")
@onready var quest_list_container: VBoxContainer = $UiPopup/QuestListContainer
@onready var embark_sound: AudioStreamPlayer = $EmbarkSound

signal on_close()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_quests()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_button_pressed() -> void:
	on_close.emit()

func load_quests() -> void:
	#for now just some forced levels
	for key in GameConstants.LOCATION_DETAILS:
		var newQuest : QuestHeader = quest_heading_scene.instantiate()
		var locationDetails = GameConstants.LOCATION_DETAILS[key]
		newQuest.location_type = key
		newQuest.quest_name = locationDetails["Name"]
		var iconLocation = locationDetails.get("Icon")
		if iconLocation != null:
			var icon = ResourceLoader.load(iconLocation)
			newQuest.location_icon = icon
		var bricks = locationDetails["Bricks"]
		for i in bricks.keys():
			newQuest.possible_bricks.append(int(i))
		quest_list_container.add_child(newQuest)
	
	#listen for clicks to embark
	var quests = quest_list_container.get_children().filter(_is_quest_heading)
	quests.map(_subscribe_to_quest)

func _is_quest_heading(node: Node) -> bool:
	return node.is_in_group("QuestHeading")
	
func _subscribe_to_quest(questHeading : QuestHeader) -> void:
	questHeading.on_embark_pressed.connect(_on_quest_embark_pressed)

func _on_quest_embark_pressed(locationId : int) -> void:
	embark_sound.play()
	
	#somehow load a level properly
	PlayerStats.currentLocation = locationId
	var details = GameConstants.LOCATION_DETAILS[locationId]
	SceneTransitions.fade_out(details.get("Name", "Level Name"))
	await SceneTransitions.fade_complete
	
	get_tree().change_scene_to_file("res://scenes/brickBreaker/level.tscn")
