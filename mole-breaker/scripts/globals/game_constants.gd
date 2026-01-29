extends Node

enum BrickType {BRICK_DIRT, BRICK_ROCK, BRICK_WOOD}

func is_brick(node : Node) -> bool:
	return node.is_in_group("Brick")

const AUDIO_BUS_NAME_EFFECTS : String = "Effects"
const AUDIO_BUS_NAME_MASTER : String = "Master"
const AUDIO_BUS_NAME_MUSIC : String = "Music"

const SAVE_DATA_FILE_NAME : String = "user://savegame.save"
const SAVE_DATA_PLAYER_STATS : String = "PLAYER_STATS"
const SAVE_DATA_PLAYER_STATS_BRICK_INVENTORY : String = "BRICK_INVENTORY"
const SAVE_DATA_TOWN : String = "TOWN"
const SAVE_DATA_TOWN_BUILDINGS : String = "BUILDINGS"

const SAVE_DATA_SETTINGS : String = "SETTINGS"
const SAVE_DATA_SETTINGS_USE_CRT_SHADER : String = "USE_CRT_SHADER"
const SAVE_DATA_SETTINGS_VOLUME_EFFECTS : String = "EFFECTS"
const SAVE_DATA_SETTINGS_VOLUME_MASTER : String = "VOLUME_MASTER"
const SAVE_DATA_SETTINGS_VOLUME_MUSIC : String = "VOLUME_MUSIC"
