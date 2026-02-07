extends Node2D

@onready var brickObject = preload("res://scenes/brickBreaker/brick.tscn")
@onready var snowBallScene = preload("res://scenes/brickBreaker/snow_ball.tscn")
@onready var ghostBallScene = preload("res://scenes/brickBreaker/ghost_ball.tscn")
@onready var uiLayer : PlayerUI = $CanvasLayer
@onready var touchControls : MobileTouchControls = $TouchControls
@onready var crtShader : CanvasLayer = $CRTShader
@onready var audioStreamPlayer: AudioStreamPlayer = $BrickAudioPlayer
@onready var background: TextureRect = $Background

# load brick images
@onready var imgBrickDirt = preload(GameConstants.RESOURCE_LOCATION_BRICK_DIRT)
@onready var imgBrickDirtDamaged = preload(GameConstants.RESOURCE_LOCATION_BRICK_DIRT_DAMAGED)
@onready var imgBrickRock = preload(GameConstants.RESOURCE_LOCATION_BRICK_ROCK)
@onready var imgBrickRockDamaged = preload(GameConstants.RESOURCE_LOCATION_BRICK_ROCK_DAMAGED)
@onready var imgBrickWood = preload(GameConstants.RESOURCE_LOCATION_BRICK_WOOD)
@onready var imgBrickWoodDamaged = preload(GameConstants.RESOURCE_LOCATION_BRICK_WOOD_DAMAGED)

# brick stats
var dirtHealth = 2
var dirtPointsPerHit = 1
var rockHealth = 4
var rockPointsPerHit = 3
var woodHealth = 3
var woodPointsPerHit = 2

var columns = 5
var rows  = 3
var margin = 13.33

var levelName : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match OS.get_name():
		"Android", "iOS":
			touchControls.show()
		_:
			touchControls.hide()
	addBall()
	setupLevel()
	uiLayer.load_bricks()
	
	crtShader.visible = Settings.useCrtShader
	SceneTransitions.fade_in()
	AmbientMusic.play_ambient_music(AmbientMusicPlayer.MUSIC_NAME_GARDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func addBall() -> void:
	match PlayerStats.chosenBall:
		GameConstants.BallType.SNOW_BALL:
			var ball : BallBase = snowBallScene.instantiate()
			ball.position = Vector2(384, 1059)
			add_child(ball)

func setupLevel() -> void:
	PlayerStats.rest_score()
	PlayerStats.reset_lives()
	
	var questDetails : Quest = GameObjects.QUEST_DETAILS.get(PlayerStats.currentQuestId)
	if questDetails == null:
		get_tree().change_scene_to_file("res://scenes/town/town.tscn")
	else:
		levelName = questDetails.name
		
		var backgroundLocation = questDetails.location_details.background_reference
		if backgroundLocation != null:
			var backgroundImage = ResourceLoader.load(backgroundLocation)
			background.texture = backgroundImage
			
		#build bricks
		var totalChances = -1
		var brickChanceMappings : Array[BrickChance] = []
		var locationBricksPart = questDetails.brick_availabilities
		for key in locationBricksPart:
			var brickChance : BrickChance = BrickChance.new()
			brickChance.brick_type = key
			brickChance.brick_chance_weight = float(locationBricksPart[key])
			brickChance.min_chance = totalChances + 1
			brickChance.max_chance = brickChance.min_chance + brickChance.brick_chance_weight
			totalChances = brickChance.max_chance
			brickChanceMappings.append(brickChance)
		
		for r in rows:
			for c in columns:
				var col_pos = 64 + (c * 128)
				var col_margins = margin + (c * margin)
				
				var row_pos = 192 + (r * 64)
				var row_margins = margin + (r * margin)
				
				var newBrick : BreakableBrick = brickObject.instantiate()
				var random_num = randi() % int(totalChances) + 1
				#for bricks in chance mappings
				for brickChance in brickChanceMappings:
					#if random_num between min and max chance.. then create that brick type
					if random_num >= brickChance.min_chance and random_num <= brickChance.max_chance:
						match brickChance.brick_type:
							GameConstants.BrickType.BRICK_DIRT:
								newBrick.healthy_texture = imgBrickDirt
								newBrick.damaged_texture = imgBrickDirtDamaged
								newBrick.starting_health = dirtHealth
								newBrick.points_per_hit = dirtPointsPerHit
								newBrick.brick_type = GameConstants.BrickType.BRICK_DIRT
							GameConstants.BrickType.BRICK_ROCK:
								newBrick.healthy_texture = imgBrickRock
								newBrick.damaged_texture = imgBrickRockDamaged
								newBrick.starting_health = rockHealth
								newBrick.points_per_hit = rockPointsPerHit
								newBrick.brick_type = GameConstants.BrickType.BRICK_ROCK
							GameConstants.BrickType.BRICK_WOOD:
								newBrick.healthy_texture = imgBrickWood
								newBrick.damaged_texture = imgBrickWoodDamaged
								newBrick.starting_health = woodHealth
								newBrick.points_per_hit = woodPointsPerHit
								newBrick.brick_type = GameConstants.BrickType.BRICK_WOOD
								
				#print(newBrick.position)
				newBrick.position = Vector2(col_margins + col_pos, row_margins + row_pos)
				add_child(newBrick)
				
		#listen for breaks to know when complete
		var bricks = get_children().filter(GameConstants.is_brick)
		bricks.map(subscribe_to_brick)

func subscribe_to_brick(brick: BreakableBrick) -> void:
	brick.OnBreak.connect(_on_brick_break)

func _on_brick_break(_brickType : GameConstants.BrickType, _quantity : int) -> void:
	var remaining_brick_nodes : Array[Node] = get_children().filter(GameConstants.is_brick)
	var count_bricks_with_health = 0
	
	for brick in remaining_brick_nodes:
		if brick is BreakableBrick:
			if brick.health > 0:
				count_bricks_with_health = count_bricks_with_health + 1

	if count_bricks_with_health == 0:
		game_over()
	
	
func _save_data() -> void:
	GameSaveService.save_game()

func game_over ():
	var balls = get_children().filter(GameConstants.is_ball)
	for ball in balls:
		ball.process_mode = Node.PROCESS_MODE_DISABLED
	uiLayer.show_level_end_overlay()
	ExperienceBus.give_experience.emit(PlayerStats.score)
	call_deferred("_save_data")

func _on_catch_bucket_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):
		var ball : BallBase = body
		
		PlayerStats.lives -= 1
		if PlayerStats.lives <= 0:
			game_over()
		
		ball.reset_position()
