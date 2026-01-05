extends Node2D

@onready var brickObject = preload("res://scenes/brick.tscn")
@onready var uiLayer : PlayerUI = $CanvasLayer
@onready var touchControls : MobileTouchControls = $TouchControls

# load brick images
@onready var imgBrickDirt = preload("res://assets/bricks/brick dirt.png")
@onready var imgBrickDirtDamaged = preload("res://assets/bricks/brick dirt cracked.png")
@onready var imgBrickRock = preload("res://assets/bricks/brick rock.png")
@onready var imgBrickRockDamaged = preload("res://assets/bricks/brick rock cracked.png")

# brick stats
var dirtHealth = 2
var dirtPointsPerHit = 1
var rockHealth = 4
var rockPointsPerHit = 3

var columns = 5
var rows  = 7
var margin = 13.33

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match OS.get_name():
		"Android", "iOS":
			touchControls.show()
		_:
			touchControls.hide()
	setupLevel()
	uiLayer.load_bricks()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func setupLevel():
	for r in rows:
		for c in columns:
			var col_pos = 64 + (c * 128)
			var col_margins = margin + (c * margin)
			
			var row_pos = 32 + (r * 64)
			var row_margins = margin + (r * margin)
			
			var newBrick : BreakableBrick = brickObject.instantiate()
			var random_num = randi() % 10
			match random_num:
				7, 8, 9, 10:
					newBrick.healthy_texture = imgBrickRock
					newBrick.damaged_texture = imgBrickRockDamaged
					newBrick.starting_health = rockHealth
					newBrick.points_per_hit = rockPointsPerHit
					newBrick.brick_type = GameConstants.BrickType.BRICK_ROCK
				_:
					newBrick.healthy_texture = imgBrickDirt
					newBrick.damaged_texture = imgBrickDirtDamaged
					newBrick.starting_health = dirtHealth
					newBrick.points_per_hit = dirtPointsPerHit
					newBrick.brick_type = GameConstants.BrickType.BRICK_DIRT
			#print(newBrick.position)
			newBrick.position = Vector2(col_margins + col_pos, row_margins + row_pos)
			add_child(newBrick)
			
			#print(newBrick.position)
