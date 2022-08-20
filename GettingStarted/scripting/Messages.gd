extends Label

func _on_Robot_health_depleted(message):
	var timer = get_node("MessagesTimer")
	timer.start(5.0)
	
	# Display the message
	text = message
	var blah = timer.is_stopped()
	var neato = timer.paused
	var funky = 1

func _on_MessagesTimer_timeout():
	print("here")
	text = ""
