extends Node

enum BrickType {BRICK_DIRT, BRICK_ROCK, BRICK_WOOD}
enum BreakerLocationType {PLAINS, FOREST, QUARRY}
enum BallType {SNOW_BALL, GHOST_BALL}
enum BuildingType {TAVERN, HOUSE, STORE, SMITHY}

func is_brick(node : Node) -> bool:
	return node.is_in_group("Brick")

func is_ball(node : Node) -> bool:
	return node.is_in_group("Ball")

const AUDIO_BUS_NAME_EFFECTS : String = "Effects"
const AUDIO_BUS_NAME_MASTER : String = "Master"
const AUDIO_BUS_NAME_MUSIC : String = "Music"

const RESOURCE_LOCATION_BRICK_DIRT : String  = "res://assets/bricks/brick dirt.png"

const RESOURCE_LOCATION_BRICK_DIRT_DAMAGED : String = "res://assets/bricks/brick dirt cracked.png"
const RESOURCE_LOCATION_BRICK_ROCK : String = "res://assets/bricks/brick rock.png"
const RESOURCE_LOCATION_BRICK_ROCK_DAMAGED : String = "res://assets/bricks/brick rock cracked.png"
const RESOURCE_LOCATION_BRICK_WOOD : String = "res://assets/bricks/brick wood.png"
const RESOURCE_LOCATION_BRICK_WOOD_DAMAGED : String = "res://assets/bricks/brick wood cracked.png"

#region saveData

const SAVE_DATA_FILE_NAME : String = "user://savegame.save"

const SAVE_DATA_PLAYER_STATS : String = "PLAYER_STATS"
const SAVE_DATA_PLAYER_STATS_BRICK_INVENTORY : String = "BRICK_INVENTORY"
const SAVE_DATA_PLAYER_STATS_BUILDINGS_UNLOCKED : String = "BUILDINGS"
const SAVE_DATA_PLAYER_STATS_CHOSEN_BALL : String = "CHOSEN_BALL"
const SAVE_DATA_PLAYER_STATS_CURRENT_XP : String = "CURRENT_XP"

const SAVE_DATA_TOWN : String = "TOWN"
const SAVE_DATA_TOWN_BUILDINGS : String = "BUILDINGS"

const SAVE_DATA_SETTINGS : String = "SETTINGS"
const SAVE_DATA_SETTINGS_USE_CRT_SHADER : String = "USE_CRT_SHADER"
const SAVE_DATA_SETTINGS_VOLUME_EFFECTS : String = "EFFECTS"
const SAVE_DATA_SETTINGS_VOLUME_MASTER : String = "VOLUME_MASTER"
const SAVE_DATA_SETTINGS_VOLUME_MUSIC : String = "VOLUME_MUSIC"

#endregion

#region townInfo

const TOWN_INFO_HOUSE : String = "[p]Unlocked at level 2.[/p][p][br] [br] [br][/p][p]Visit here to see your current inventory, Selected ball and Character.[/p]"

#endregion
