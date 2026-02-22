extends Node

var score : int = 0
var lives: int = 3

var brickInventory: Dictionary[GameConstants.BrickType, int] = {}
var chosenBall: GameConstants.BallType = GameConstants.BallType.SNOW_BALL
var unlockedBuildings: Array[GameConstants.BuildingType] = [GameConstants.BuildingType.TAVERN]

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
	
#region inventory

func add_to_inventory(brick_type: GameConstants.BrickType, amount: int) -> void:
	if brickInventory.has(brick_type):
		var brick_amount = brickInventory[brick_type]
		brickInventory[brick_type] = brick_amount + amount
	else:
		brickInventory[brick_type] = amount

func can_afford(brick_costs: Dictionary[GameConstants.BrickType, int]) -> bool:
	for type in brick_costs:
		var qtyRequired = brick_costs[type]
		var ownedQty : int = brickInventory.get(type, 0)
		if ownedQty < qtyRequired:
			return false
	return true

func pay_cost(brick_costs: Dictionary[GameConstants.BrickType, int]) -> bool:
	if !can_afford(brick_costs):
		return false
	else:
		for type in brick_costs:
			var qtyRequired = brick_costs[type]
			var ownedQty : int = brickInventory.get(type, 0)
			brickInventory[type] = ownedQty - qtyRequired
	
	#clear empty entries
	var keys = brickInventory.keys()
	for i in keys:
		if brickInventory[i] <= 0:
			brickInventory.erase(i)
	
	return true

#endregion

#region levelling
func _give_experience(value : int) -> void:
	currentExperience = currentExperience + value
	
	while currentExperience >= maxExperience:
		_level_up()
		
func _level_up() -> void:
	lastLevelExperienceCap = maxExperience
	maxExperience = get_next_xp_cap(maxExperience)
	currentLevel = currentLevel + 1
	nextLevelExperience = maxExperience - currentExperience
	_unlock_buildings()
	ExperienceBus.level_increased.emit(currentLevel)

func get_next_xp_cap(cap : int) -> int:
	return cap * 2
#endregion

#region buildings
func _unlock_buildings() -> void:
	for key in GameObjects.BUILDING_DETAILS:
		var building : BuildingMapping = GameObjects.BUILDING_DETAILS[key]
		if building.level_requirement <= currentLevel:
			if not unlockedBuildings.any(func(number): return number == building.building_type) and building.brick_cost.size() == 0:
				unlockedBuildings.append(building.building_type)

func unlock_building(type: GameConstants.BuildingType, brick_costs: Dictionary[GameConstants.BrickType, int]) -> bool:
	if unlockedBuildings.any(func(number): return number == type):
		return true
	if !pay_cost(brick_costs):
		return false
	unlockedBuildings.append(type)
	GameSaveService.save_game()
	return true

#endregion

#region save data
func get_save_data() -> Dictionary:
	var save_data = {
		GameConstants.SAVE_DATA_PLAYER_STATS_BRICK_INVENTORY : brickInventory,
		GameConstants.SAVE_DATA_PLAYER_STATS_CURRENT_XP : currentExperience,
		GameConstants.SAVE_DATA_PLAYER_STATS_CHOSEN_BALL : chosenBall,
		GameConstants.SAVE_DATA_PLAYER_STATS_BUILDINGS_UNLOCKED : unlockedBuildings
	}
	
	return save_data

func load_data(data: Dictionary) -> void:
	var brickInventoryPart = data[GameConstants.SAVE_DATA_PLAYER_STATS_BRICK_INVENTORY]
	for key in brickInventoryPart.keys():
		var brick_type = int(key)
		brickInventory[brick_type] = int(brickInventoryPart[key])
	
	var dataArray = data.get(GameConstants.SAVE_DATA_PLAYER_STATS_BUILDINGS_UNLOCKED, [GameConstants.BuildingType.TAVERN] as Array[GameConstants.BuildingType])
	var buildings : Array[GameConstants.BuildingType]
	buildings.assign(dataArray.map(func(b): return int(b)))
	
	unlockedBuildings = buildings
	
	currentExperience = int(data.get(GameConstants.SAVE_DATA_PLAYER_STATS_CURRENT_XP, 0))
	while currentExperience >= maxExperience:
		_level_up()
	
	var foundChosenBall = int(data.get(GameConstants.SAVE_DATA_PLAYER_STATS_CHOSEN_BALL, -1))
	if foundChosenBall >= 0:
		chosenBall = foundChosenBall as GameConstants.BallType
#endregion
