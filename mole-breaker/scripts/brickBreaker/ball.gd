extends CharacterBody2D
class_name BallBase

@onready var bounce_sound: AudioStreamPlayer = $BounceSound

@export var base_speed = 250
@export var bounce_multiplier = 1.05
@export var max_speed = 600
@export var damage = 1

var is_active = true

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	velocity = Vector2(base_speed * -1, base_speed)

func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		if collision:
			var collider = collision.get_collider()
			if collider is Node:
				if collider.is_in_group("Wall") or collider.is_in_group("Paddle") or collider.is_in_group("Brick"):
					#get the bounce direction
					velocity = velocity.bounce(collision.get_normal())
					velocity = velocity * bounce_multiplier
					
					bounce_sound.play()
		
		if (velocity.y > 0 and velocity.y < 100):
			velocity.y = -base_speed
		if velocity.x == 0:
			velocity.x = -base_speed
		
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
		velocity.y = clamp(velocity.y, -max_speed, max_speed)

func reset_position() -> void:
	position = Vector2(384, 1059)
	velocity = Vector2(base_speed, base_speed * -1)
