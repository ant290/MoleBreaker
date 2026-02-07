extends BallBase

func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		if collision:
			var collider = collision.get_collider()
			if collider is Node:
				if collider.is_in_group("Wall") or collider.is_in_group("Paddle"):
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
