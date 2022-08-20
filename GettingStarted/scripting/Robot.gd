extends Sprite

# Define a signal that we've died
signal health_depleted(message)

# Member variables we'll need
var health = 3
var speed = 400
var angular_speed = PI

# This function runs when the node is initiated
func _init():
	print("Hello, world!")

# This function runs when the node is ready, defines a signal in code
func _ready():
	var timer = get_node("Timer")
	timer.connect("timeout", self, "_on_Timer_timeout")

# Process input from the player
func _process(delta):
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta

# This function controls when the node takes damage
func take_damage(amount):
	health -= amount
	if health <= 0:
		emit_signal("health_depleted", "Blegh!")
		visible = false

# This is an experimental function for manual player movement
func allow_player_movement(delta):
	# Handle input
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1

	# Set the rotation
	rotation += angular_speed * direction * delta
	
	# Handle forward movement
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed

	# Set the new position
	position += velocity * delta

# This event handler takes care of the UI button getting clicked
func _on_Button_pressed():
	set_process(not is_processing())

# This event handler takes care of the timer expiring
func _on_Timer_timeout():
	if health > 0:
		take_damage(1)
		print("Health:" + String(health))
