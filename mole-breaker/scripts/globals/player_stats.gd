extends Node

var score : int = 0
var lives: int = 3

var brickInventory: Dictionary[GameConstants.BrickType, int] = {}
var chosenBall: GameConstants.BallType = GameConstants.BallType.SNOW_BALL

var currentQuestId : int

#region xp system

var currentExperience : int = 0
var maxExperience : int = 90
var currentLevel : int = 1
var nextLevelExperience : int
var lastLevelExperienceCap : int = 0

#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ExperienceBus.give_experience.connect(_give_experience)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_quest(questId : int) -> void:
	currentQuestId = questId

func reset_lives() -> void:
	lives = 3

func rest_score() -> void:
	score = 0
	
func add_to_inventory(brick_type: GameConstants.BrickType, amount: int) -> void:
	if brickInventory.has(brick_type):
		var brick_amount = brickInventory[brick_type]
		brickInventory[brick_type] = brick_amount + amount
	else:
		brickInventory[brick_type] = amount

func _give_experience(value : int) -> void:
	currentExperience = currentExperience + value
	
	while currentExperience >= maxExperience:
		_level_up()
		
func _level_up() -> void:
	lastLevelExperienceCap = maxExperience
	maxExperience = get_next_xp_cap(maxExperience)
	currentLevel = currentLevel + 1
	nextLevelExperience = maxExperience - currentExperience

func get_next_xp_cap(cap : int) -> int:
	return cap * 2

#region save data
func get_save_data() -> Dictionary:
	var save_data = {
		GameConstants.SAVE_DATA_PLAYER_STATS_BRICK_INVENTORY : brickInventory,
		GameConstants.SAVE_DATA_PLAYER_STATS_CURRENT_XP : currentExperience,
		GameConstants.SAVE_DATA_PLAYER_STATS_CHOSEN_BALL : chosenBall
	}
	
	return save_data

func load_data(data: Dictionary) -> void:
	var brickInventoryPart = data[GameConstants.SAVE_DATA_PLAYER_STATS_BRICK_INVENTORY]
	for key in brickInventoryPart.keys():
		var brick_type = int(key)
		brickInventory[brick_type] = int(brickInventoryPart[key])
	
	currentExperience = int(data.get(GameConstants.SAVE_DATA_PLAYER_STATS_CURRENT_XP, 0))
	while currentExperience >= maxExperience:
		_level_up()
	
	var foundChosenBall = int(data.get(GameConstants.SAVE_DATA_PLAYER_STATS_CHOSEN_BALL, -1))
	if foundChosenBall >= 0:
		chosenBall = foundChosenBall as GameConstants.BallType
#endregion
