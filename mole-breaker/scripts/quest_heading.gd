extends HSplitContainer
class_name QuestHeader

#possibly refactor these into one object
@export var location_type : GameConstants.BreakerLocationType
@export var quest_name : String = "name"
@export var possible_bricks : Array[int] = []

signal on_embark_pressed(locationId : int)

@onready var location_label: Label = $QuestDetails/HSplitContainer/LocationLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	location_label.text = quest_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_embark_button_pressed() -> void:
	on_embark_pressed.emit(location_type)
