extends ColorRect
class_name InventoryPopup

signal on_close()

@onready var inventory_item_scene = preload("res://scenes/inventory_item.tscn")
@onready var inven_items_container : VBoxContainer = $UiPopup/VBoxContainer
@onready var level: Label = $UiPopup/PlayerLevelContainer/Level
@onready var xp_to_next: Label = $UiPopup/PlayerLevelContainer/XPToNext

# load brick images
@onready var imgBrickDirt = preload(GameConstants.RESOURCE_LOCATION_BRICK_DIRT)
@onready var imgBrickRock = preload(GameConstants.RESOURCE_LOCATION_BRICK_ROCK)
@onready var imgBrickWood = preload(GameConstants.RESOURCE_LOCATION_BRICK_WOOD)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_inventory()
	load_stats()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func refresh() -> void:
	load_inventory()
	load_stats()

func is_brick_type(item: InventoryItem, number):
	return item.brick_type == number

func load_inventory() -> void:
	var children = inven_items_container.get_children()
	
	for brick in PlayerStats.brickInventory:
		var found_child = children.find_custom(is_brick_type.bind(brick))

		if found_child > -1:
			children[found_child].quantity = PlayerStats.brickInventory[brick]
			children[found_child].update()

		else:
			#create new item
			var newBrick : InventoryItem = inventory_item_scene.instantiate()
			newBrick.brick_type = brick
			newBrick.quantity = PlayerStats.brickInventory[brick]

			# probably refactor to new method to set the sprite
			match brick:
				GameConstants.BrickType.BRICK_DIRT:
					newBrick.sprite_texture = imgBrickDirt
				GameConstants.BrickType.BRICK_ROCK:
					newBrick.sprite_texture = imgBrickRock
				GameConstants.BrickType.BRICK_WOOD:
					newBrick.sprite_texture = imgBrickWood
			
			inven_items_container.add_child(newBrick)

func load_stats() -> void:
	level.text = "Level: " + str(PlayerStats.currentLevel)
	xp_to_next.text = "XP to level up: " + str(PlayerStats.nextLevelExperience)

func _on_close_button_pressed() -> void:
	on_close.emit()
