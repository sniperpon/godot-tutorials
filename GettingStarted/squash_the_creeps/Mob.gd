extends KinematicBody

signal squashed

# Set some parameters
export var min_speed = 10
export var max_speed = 18
var velocity = Vector3.ZERO


# This function will initialize the enemy
func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)

	# Rotate it slightly so it's not aimed right at the player
	rotate_y(rand_range(-PI / 4, PI / 4))

	# Give it a random speed and corresponding vector
	var random_speed = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed

	# Rotate the vector to the mob's direction
	velocity = velocity.rotated(Vector3.UP, rotation.y)


# Process the physics for the frame
func _physics_process(_delta):
	move_and_slide(velocity)


# Clean up this enemy if it went off the screen
func _on_VisibilityNotifier_screen_exited():
	queue_free()


# Handle when the enemy gets jumped on
func squash():
	emit_signal("squashed")
	queue_free()
