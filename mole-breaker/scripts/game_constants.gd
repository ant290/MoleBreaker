extends Node

enum BrickType {BRICK_DIRT, BRICK_ROCK}

func is_brick(node : Node) -> bool:
	return node.is_in_group("Brick")

const SAVE_DATA_FILE_NAME : String = "user://savegame.save"
const SAVE_DATA_PLAYER_STATS : String = "PLAYER_STATS"
const SAVE_DATA_PLAYER_STATS_BRICK_INVENTORY : String = "BRICK_INVENTORY"
