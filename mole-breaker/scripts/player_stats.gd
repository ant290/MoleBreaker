extends Node

var score : int = 0
var lives: int = 4
var brickInventory: Dictionary[GameConstants.BrickType, int] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_to_inventory(brick_type: GameConstants.BrickType, amount: int) -> void:
	if brickInventory.has(brick_type):
		var brick_amount = brickInventory[brick_type]
		brickInventory[brick_type] = brick_amount + amount
	else:
		brickInventory[brick_type] = amount
