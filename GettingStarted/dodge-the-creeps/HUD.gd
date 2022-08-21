extends CanvasLayer

signal start_game


# This function will display a message
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


# Hide the message once the message timer has expired
func _on_MessageTimer_timeout():
	$Message.hide()


# This function handles score updates to the HUD
func update_score(score):
	$ScoreLabel.text = str(score)


# This function handles game over HUD display stuff
func show_game_over():
	show_message("Game Over")

	# Wait until the MessageTimer has counted down
	yield($MessageTimer, "timeout")

	# Reset the message
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()

	# Re-show the button via a one-shot timer, wait for it to finish
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()


# They pressed the start button
func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
