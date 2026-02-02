extends NinePatchRect
class_name QuestHeader

#possibly refactor these into one object
var quest : Quest

signal on_embark_pressed(locationId : int)

@onready var location_label: Label = $QuestSplitContainer/QuestDetails/HBoxContainer/LocationLabel
@onready var brick_examples: HBoxContainer = $QuestSplitContainer/QuestDetails/PanelContainer/BrickExamples
@onready var quest_image: TextureRect = $QuestSplitContainer/QuestImage

# load brick images
@onready var imgBrickDirt = preload(GameConstants.RESOURCE_LOCATION_BRICK_DIRT)
@onready var imgBrickRock = preload(GameConstants.RESOURCE_LOCATION_BRICK_ROCK)
@onready var imgBrickWood = preload(GameConstants.RESOURCE_LOCATION_BRICK_WOOD)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	location_label.text = quest.name
	var icon = ResourceLoader.load(quest.location_details.icon_reference)
	quest_image.texture = icon
	_load_possible_bricks()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _load_possible_bricks() -> void:
	for brick in quest.brick_availabilities:
		var image : TextureRect = TextureRect.new()
		image.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		image.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		image.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		image.custom_minimum_size = Vector2(0,32)
		match brick:
			GameConstants.BrickType.BRICK_DIRT:
				image.texture = imgBrickDirt
			GameConstants.BrickType.BRICK_ROCK:
				image.texture = imgBrickRock
			GameConstants.BrickType.BRICK_WOOD:
				image.texture = imgBrickWood
		brick_examples.add_child(image)

func _on_embark_button_pressed() -> void:
	on_embark_pressed.emit(quest.id)
