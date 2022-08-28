extends Area2D

# Here are signals we will require
signal hit


# Here are member variables we'll need
export var speed = 400
var screen_size


# This function fires when the node enters a scene
func _ready():
	screen_size = get_viewport_rect().size
	
	# Hide the player when the scene starts
	hide()


# This function 'resets' the player state
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


# This function runs every frame
func _process(delta):
	var velocity = Vector2.ZERO

	# Adjust velocity if the player hit any movement keys
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	# If they are moving, enable animation
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	# Set the player's position then, and 'clamp' the values to the screen size
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# Run the correct animation
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


# This function handles an enemy crashing into the player
func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	
	# Disable the collision box so we don't infinitely trip!
	# Deferred; we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
