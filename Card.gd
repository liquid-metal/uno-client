extends ColorRect


func set_look(card):
	$Label.set("custom_colors/font_color", Color(1, 1, 1, 1))
	if card[0] == 'r':
		color = Color(1, 0, 0, 1)
	elif card[0] == 'g':
		color = Color(0, 1, 0, 1)
	elif card[0] == 'b':
		color = Color(0, 0, 1, 1)
	elif card[0] == 'y':
		$Label.set("custom_colors/font_color", Color(0, 0, 0, 1))
		color = Color(1, 1, 0, 1)
	elif card[0] == 's':
		color = Color(0, 0, 0, 1)
	$Label.text = card[1]
