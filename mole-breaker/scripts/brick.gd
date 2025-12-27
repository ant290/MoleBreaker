extends RigidBody2D
class_name BreakableBrick

signal OnHit(points : int)

@export var starting_health : int = 2
@export var points_per_hit : int = 1

@onready var healthy_sprite : Sprite2D = $HealthySprite
@onready var damaged_sprite : Sprite2D = $DamagedSprite

var health : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = starting_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit():
	health -= 1
	OnHit.emit(points_per_hit)
	if health <= starting_health / 2:
		#load broken sprite
		damaged_sprite.show()
		healthy_sprite.hide()
		
	if health <= 0:
		
		healthy_sprite.hide()
		damaged_sprite.hide()
	
		await get_tree().create_timer(1).timeout
	
		queue_free()
