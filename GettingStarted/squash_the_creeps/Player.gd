extends KinematicBody

signal hit

# How fast the player moves in meters per second.
export var speed = 14

# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75
export var jump_impulse = 20
export var bounce_impulse = 16

# Set the velocity vector
var velocity = Vector3.ZERO


# This function handles the player's movement
func _physics_process(delta):
	var direction = Vector3.ZERO

	# Set the vector according to input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	# Trim the vector and point the pivot
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)

	# Now finally we adjust the velocities; make the character fall
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta

	# Handle jumping, let them only if they are on the floor
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse

	# Make the character actually move
	velocity = move_and_slide(velocity, Vector3.UP)

	# Handle any collisions which may have occurred
	for index in range(get_slide_count()):
		var collision = get_slide_collision(index)

		# Did we collide with an enemy?
		if collision.collider.is_in_group("mob"):
			var mob = collision.collider

			# Were we above the enemy?
			if Vector3.UP.dot(collision.normal) > 0.1:
				mob.squash()
				velocity.y = bounce_impulse


# This function will kill off the player
func die():
	emit_signal("hit")
	queue_free()


# This function handles collisions with an enemy
func _on_MobDetector_body_entered(body):
	die()
