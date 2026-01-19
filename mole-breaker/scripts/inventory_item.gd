extends HSplitContainer
class_name InventoryItem

@export var sprite_texture : Texture2D
@export var quantity : int = 0
@export var brick_type : GameConstants.BrickType

@onready var sprite : TextureRect = $Sprite
@onready var quantity_label : Label = $Quantity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = sprite_texture
	quantity_label.text = str(quantity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update() -> void:
	quantity_label.text = str(quantity)
