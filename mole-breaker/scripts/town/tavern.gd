extends Area2D

@onready var sprite: Sprite2D = $Sprite

signal on_click()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PlayerStats.unlockedBuildings.any(func(number): return number == GameConstants.BuildingType.TAVERN):
		sprite.modulate = Color(1,1,1,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_released():
		on_click.emit()
