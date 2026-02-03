extends CharacterBody2D

signal OnOutOfBounds()

@onready var bounce_sound: AudioStreamPlayer = $BounceSound

@export var base_speed = 250
@export var bounce_multiplyer = 1.05

var is_active = true

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	velocity = Vector2(base_speed * -1, base_speed)

func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		if collision:
			#get the bounce direction
			velocity = velocity.bounce(collision.get_normal())
			
			if collision.get_collider().has_method("hit"):
				collision.get_collider().hit()
			
			velocity = velocity * bounce_multiplyer
			
			bounce_sound.play()
		
		if (velocity.y > 0 and velocity.y < 100):
			velocity.y = -base_speed
		if velocity.x == 0:
			velocity.x = -base_speed
		
		velocity.x = clamp(velocity.x, -600, 600)
		velocity.y = clamp(velocity.y, -600, 600)

func _on_catch_bucket_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Ball"):
		return
	
	position = Vector2(384, 1059)
	velocity = Vector2(base_speed, base_speed * -1)

	OnOutOfBounds.emit()
