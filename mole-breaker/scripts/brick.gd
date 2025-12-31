extends RigidBody2D
class_name BreakableBrick

signal OnHit(points : int)

@export var starting_health : int = 2
@export var points_per_hit : int = 1

@onready var healthy_sprite : Sprite2D = $HealthySprite
@onready var damaged_sprite : Sprite2D = $DamagedSprite
@onready var animator : AnimationPlayer = $AnimationPlayer

var health : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = starting_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit():
	#set the brick health, call animation and emit points signal
	health -= 1
	animator.play("dink")
	OnHit.emit(points_per_hit)
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#here handling the changing of sprites and killing the brick
	if health <= starting_health / 2:
		#load broken sprite
		damaged_sprite.show()
		healthy_sprite.hide()
	if health <= 0:
		healthy_sprite.hide()
		damaged_sprite.hide()
		call_deferred("queue_free")
