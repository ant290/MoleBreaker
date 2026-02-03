extends RigidBody2D
class_name BreakableBrick

signal OnHit(points : int)
signal OnBreak(brick_type: GameConstants.BrickType, quantity : int)

@export var starting_health : int = 2
@export var points_per_hit : int = 1
@export var healthy_texture : Texture2D
@export var damaged_texture : Texture2D
@export var brick_type : GameConstants.BrickType = GameConstants.BrickType.BRICK_DIRT
@export var quantity_dropped : int = 1

@onready var healthy_sprite : Sprite2D = $HealthySprite
@onready var damaged_sprite : Sprite2D = $DamagedSprite
@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var brick_audio_player: AudioStreamPlayer = $BrickAudioPlayer


var health : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = starting_health
	healthy_sprite.texture = healthy_texture
	damaged_sprite.texture = damaged_texture
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func hit():
	#set the brick health, call animation and emit points signal
	health -= 1
	animator.play("dink")
	OnHit.emit(points_per_hit)
	if health <= 0:
		OnBreak.emit(brick_type, quantity_dropped)
	

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	#here handling the changing of sprites and killing the brick
	if health <= starting_health / 2:
		brick_audio_player.play_crack()
		#load broken sprite
		damaged_sprite.show()
		healthy_sprite.hide()
		
	if health <= 0:
		healthy_sprite.hide()
		damaged_sprite.hide()
		collision_shape_2d.disabled = true
		brick_audio_player.play_break()

func _on_brick_audio_player_finished() -> void:
	if health <= 0:
		call_deferred("queue_free")
