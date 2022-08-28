extends RigidBody2D


# Called when the node enters the scene
func _ready():
	$AnimatedSprite.playing = true
	
	# Get the various animation types
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	
	# Pick a random one for variety
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
