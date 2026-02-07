extends Node

#region Ball Details

const BALL_DICT : Dictionary[GameConstants.BallType, Variant] ={
	GameConstants.BallType.SNOW_BALL : {
		"Sprite" : "res://assets/balls/SnowBall.png",
		"BaseSpeed" : 250,
		"BounceMultiplier" : 1.05
	},
	GameConstants.BallType.GHOST_BALL : {
		"Sprite" : "res://assets/balls/GhostBall.png",
		"BaseSpeed" : 200,
		"BounceMultiplier" : 1.07
	}
}

#endregion

#region Location Details

const LOCATION_DICT : Dictionary[GameConstants.BreakerLocationType, Variant] = {
	GameConstants.BreakerLocationType.PLAINS : {
		"Icon" : "res://assets/locations/icon-plains.png",
		"Background" : "res://assets/locations/background-plains.png"
	},
	GameConstants.BreakerLocationType.FOREST : {
		"Icon" : "",
		"Background" : "res://assets/locations/background-forest.png"
	},
	GameConstants.BreakerLocationType.QUARRY : {
		"Icon" : "",
		"Background" : "res://assets/locations/background-quarry.png"
	}
}

# brick allocation consists of a brick type and a number for its spawn weight 
var QUEST_DICT : Dictionary[int, Variant] = {
	1 : {
		"LocationType" : GameConstants.BreakerLocationType.PLAINS,
		"Name" : "Plains",
		"MinimumLevel" : 0,
		"Bricks" : {
			GameConstants.BrickType.BRICK_DIRT : 10,
			GameConstants.BrickType.BRICK_ROCK : 2,
			GameConstants.BrickType.BRICK_WOOD : 1
		}
	},
	2 : {
		"LocationType" : GameConstants.BreakerLocationType.FOREST,
		"Name" : "Forest",
		"MinimumLevel" : 2,
		"Bricks" : {
			GameConstants.BrickType.BRICK_DIRT : 4,
			GameConstants.BrickType.BRICK_ROCK : 2,
			GameConstants.BrickType.BRICK_WOOD : 8
		}
	},
	3 : {
		"LocationType" : GameConstants.BreakerLocationType.QUARRY,
		"Name" : "Quarry",
		"MinimumLevel" : 5,
		"Bricks" : {
			GameConstants.BrickType.BRICK_DIRT : 4,
			GameConstants.BrickType.BRICK_ROCK : 8,
			GameConstants.BrickType.BRICK_WOOD : 1
		}
	}
}

#needs to be populated at run time
var LOCATION_DETAILS : Dictionary[GameConstants.BreakerLocationType, LocationDetails] = {}
var QUEST_DETAILS : Dictionary[int, Quest] = {}

#endregion

func _ready() -> void:
	#build location details
	for key in LOCATION_DICT:
		var location = LOCATION_DICT[key]
		var details = LocationDetails.new()
		details.location_type = key
		details.icon_reference = location["Icon"]
		details.background_reference = location["Background"]
		LOCATION_DETAILS[key] = details

	#build quests
	for key in QUEST_DICT:
		var item = QUEST_DICT[key]
		var quest = Quest.new()
		quest.id = key
		quest.location_details = LOCATION_DETAILS[item["LocationType"]]
		quest.name = item["Name"]
		quest.minimum_level = item["MinimumLevel"]
		var bricks = item["Bricks"]
		for brickChance in bricks:
				quest.brick_availabilities[brickChance] = bricks[brickChance]
		QUEST_DETAILS[key] = quest
