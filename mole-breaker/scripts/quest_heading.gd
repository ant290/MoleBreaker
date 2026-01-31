extends NinePatchRect
class_name QuestHeader

#possibly refactor these into one object
@export var location_type : GameConstants.BreakerLocationType
@export var quest_name : String = "name"
@export var possible_bricks : Array[int] = []
@export var location_icon: Texture2D

signal on_embark_pressed(locationId : int)

@onready var location_label: Label = $QuestSplitContainer/QuestDetails/HBoxContainer/LocationLabel
@onready var brick_examples: HBoxContainer = $QuestSplitContainer/QuestDetails/PanelContainer/BrickExamples
@onready var quest_image: TextureRect = $QuestSplitContainer/QuestImage

# load brick images
@onready var imgBrickDirt = preload("res://assets/bricks/brick dirt.png")
@onready var imgBrickRock = preload("res://assets/bricks/brick rock.png")
@onready var imgBrickWood = preload("res://assets/bricks/brick wood.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	location_label.text = quest_name
	quest_image.texture = location_icon
	_load_possible_bricks()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _load_possible_bricks() -> void:
	for brick in possible_bricks:
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
	on_embark_pressed.emit(location_type)
