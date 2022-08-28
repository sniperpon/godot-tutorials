extends Node

export (PackedScene) var mob_scene


func _ready():
	randomize()
	$UserInterface/Retry.hide()


func _on_MobTimer_timeout():
	var mob = mob_scene.instance()

	# Define an offset along the path
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.unit_offset = randf()

	# Set the new enemy's location
	var player_position = $Player.transform.origin
	mob.initialize(mob_spawn_location.translation, player_position)

	# Add the enemy to the scene
	add_child(mob)

	# Connect to the squashed signal
	mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")


# This function is hit when the player in turn is hit
func _on_Player_hit():
	$UserInterface/Retry.show()


# If the player hits enter, restart
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
