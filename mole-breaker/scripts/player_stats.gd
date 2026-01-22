extends Node

var score : int = 0
var lives: int = 4
var brickInventory: Dictionary[GameConstants.BrickType, int] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameSaveService.load_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_to_inventory(brick_type: GameConstants.BrickType, amount: int) -> void:
	if brickInventory.has(brick_type):
		var brick_amount = brickInventory[brick_type]
		brickInventory[brick_type] = brick_amount + amount
	else:
		brickInventory[brick_type] = amount
		
func get_save_data() -> Dictionary:
	var save_data = {
		GameConstants.SAVE_DATA_PLAYER_STATS_BRICK_INVENTORY : brickInventory
	}
	
	return save_data

func load_data(data: Dictionary) -> void:
	var brickInventoryPart = data[GameConstants.SAVE_DATA_PLAYER_STATS_BRICK_INVENTORY]
	
	for key in brickInventoryPart.keys():
		var brick_type = int(key)
		brickInventory[brick_type] = int(brickInventoryPart[key])
