extends CanvasLayer
class_name PlayerUI

@onready var score_text : Label = $ScoreText
@export var score_text_prompt : String = "Score: "

@onready var lives_text : Label = $LivesText
@export var lives_text_prompt : String = "Lives: "

@onready var level_name: Label = $LevelName

@onready var inventory : InventoryPopup = $Inventory

@onready var level = get_parent()

var current_level_bricks : Array = [BreakableBrick]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_score_label()
	inventory.on_close.connect(_on_inventory_closed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_handle_open_close_inventory(get_tree().paused)

func _handle_open_close_inventory(paused: bool) -> void:
	if paused:
		get_tree().paused = false
		inventory.visible = false
	else:
		get_tree().paused = true
		inventory.refresh()
		inventory.visible = true

func _on_inventory_closed() -> void:
	_handle_open_close_inventory(true)

func load_bricks() -> void:
	level_name.text = level.levelName
	current_level_bricks = level.get_children().filter(GameConstants.is_brick)
	current_level_bricks.map(subscribe_to_brick)

func subscribe_to_brick(brick: BreakableBrick) -> void:
	brick.OnHit.connect(_update_score)
	brick.OnBreak.connect(_update_inventory)

func _update_score (score : int) -> void:
	PlayerStats.score += score
	_set_score_label()
	
func _update_inventory (brickType : GameConstants.BrickType, quantity : int) -> void:
	PlayerStats.add_to_inventory(brickType, quantity)

func _set_score_label() -> void:
	score_text.text = score_text_prompt + str(PlayerStats.score)

func _on_catch_bucket_body_entered(body: Node2D) -> void:
	lives_text.text = lives_text_prompt + str(PlayerStats.lives)
