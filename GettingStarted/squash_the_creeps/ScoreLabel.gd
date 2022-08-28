extends Label

var score = 0


# When an enemy is squashed, increase the score
func _on_Mob_squashed():
	score += 1
	text = "Score: %s" % score
