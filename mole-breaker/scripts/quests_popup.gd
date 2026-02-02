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
	for key in GameObjects.QUEST_DETAILS:
		var newQuest : QuestHeader = quest_heading_scene.instantiate()
		var questDetails : Quest = GameObjects.QUEST_DETAILS[key]
		newQuest.quest = questDetails
		quest_list_container.add_child(newQuest)
	
	#listen for clicks to embark
	var quests = quest_list_container.get_children().filter(_is_quest_heading)
	quests.map(_subscribe_to_quest)

func _is_quest_heading(node: Node) -> bool:
	return node.is_in_group("QuestHeading")
	
func _subscribe_to_quest(questHeading : QuestHeader) -> void:
	questHeading.on_embark_pressed.connect(_on_quest_embark_pressed)

func _on_quest_embark_pressed(questId : int) -> void:
	embark_sound.play()
	
	#somehow load a level properly
	var details : Quest = GameObjects.QUEST_DETAILS[questId]
	PlayerStats.currentQuestId = questId
	
	SceneTransitions.fade_out(details.name)
	await SceneTransitions.fade_complete
	
	get_tree().change_scene_to_file("res://scenes/brickBreaker/level.tscn")
