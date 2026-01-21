extends CharacterBody2D

@export var base_speed = 1000.0

@onready var character_sprite : Sprite2D = $CharacterSprite

func _process(delta: float) -> void:
	
	#wiggle
	if velocity.x != 0:
		if velocity.x > 0:
			character_sprite.rotation_degrees = -7
		else:
			character_sprite.rotation_degrees = 7
	else:
		character_sprite.rotation_degrees = 0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * base_speed
	else:
		velocity.x = move_toward(velocity.x, 0, base_speed)

	move_and_collide(velocity * delta)
