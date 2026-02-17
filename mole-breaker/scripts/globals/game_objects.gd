extends Node

#region Ball Details

const BALL_DICT : Dictionary[GameConstants.BallType, Variant] ={
	GameConstants.BallType.SNOW_BALL : {
		"Scene" : "res://scenes/brickBreaker/snow_ball.tscn",
		"Sprite" : "res://assets/balls/SnowBall.png",
		"BaseSpeed" : 250,
		"MaxSpeed" : 600,
		"BounceMultiplier" : 1.05,
		"Damage" : 1
	},
	GameConstants.BallType.GHOST_BALL : {
		"Scene" : "res://scenes/brickBreaker/ghost_ball.tscn",
		"Sprite" : "res://assets/balls/GhostBall.png",
		"BaseSpeed" : 200,
		"MaxSpeed" : 600,
		"BounceMultiplier" : 1.07,
		"Damage" : 1
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

# building unlock requirements
var BUILDING_DICT : Dictionary[GameConstants.BuildingType, Variant] = {
	GameConstants.BuildingType.TAVERN : {
		"LevelRequirement" : 0
	},
	GameConstants.BuildingType.HOUSE : {
		"LevelRequirement" : 2
	}
}

#needs to be populated at run time
var LOCATION_DETAILS : Dictionary[GameConstants.BreakerLocationType, LocationDetails] = {}
var QUEST_DETAILS : Dictionary[int, Quest] = {}
var BALL_DETAILS : Dictionary[GameConstants.BallType, BallMapping] = {}
var BUILDING_DETAILS : Dictionary[GameConstants.BuildingType, BuildingMapping] = {}

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
	
	#build balls
	for key in BALL_DICT:
		var type = BALL_DICT[key]
		var mapping = BallMapping.new()
		mapping.ball_type = key
		mapping.scene_path = type["Scene"]
		mapping.sprite_path = type["Sprite"]
		mapping.base_speed = int(type.get("BaseSpeed", 250))
		mapping.max_speed = int(type.get("MaxSpeed", 600))
		mapping.bounce_multiplier = int(type.get("BounceMultiplier", 1.05))
		mapping.damage = int(type.get("Damage", 1))
		BALL_DETAILS[key] = mapping
	
	#build buildings
	for key in BUILDING_DICT:
		var type = BUILDING_DICT[key]
		var mapping = BuildingMapping.new()
		mapping.building_type = key
		mapping.level_requirement = int(type.get("LevelRequirement", 0))
		# mapping.brick_cost = {}
		BUILDING_DETAILS[key] = mapping
