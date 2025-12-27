extends Node2D

@onready var brickObject = preload("res://scenes/brick.tscn")

var columns = 5
var rows  = 7
var margin = 13.33

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setupLevel()


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
			
			var newBrick = brickObject.instantiate()
			print(newBrick.position)
			newBrick.position = Vector2(col_margins + col_pos, row_margins + row_pos)
			add_child(newBrick)
			
			print(newBrick.position)
