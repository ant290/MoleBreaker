extends CanvasLayer
class_name PlayerUI

@onready var score_text : Label = $ScoreText
@export var score_text_prompt : String = "Score: "

@onready var lives_text : Label = $LivesText
@export var lives_text_prompt : String = "Lives: "

@onready var level = get_parent()

var current_level_bricks : Array = [BreakableBrick]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_score_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_bricks() -> void:
	current_level_bricks = level.get_children().filter(is_brick)
	
	current_level_bricks.map(subscribe_to_brick_onhit)

func is_brick(node : Node) -> bool:
	return node.is_in_group("Brick")

func subscribe_to_brick_onhit(brick: BreakableBrick) -> void:
	brick.OnHit.connect(_update_score)

func _update_score (score : int) -> void:
	PlayerStats.score += score
	_set_score_label()

func _set_score_label() -> void:
	score_text.text = score_text_prompt + str(PlayerStats.score)

func _on_catch_bucket_body_entered(body: Node2D) -> void:
	lives_text.text = lives_text_prompt + str(PlayerStats.lives)
