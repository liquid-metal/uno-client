extends ColorRect


signal entered(nickname)


func _ready():
	$MarginContainer/HBoxContainer/VBoxContainer/LineEdit.grab_focus()


func textEntered(new_text):
	emit_signal("entered", new_text)


func buttonPressed():
	emit_signal("entered", $MarginContainer/HBoxContainer/VBoxContainer/LineEdit.text)


func display_available():
	$MarginContainer/HBoxContainer/VBoxContainer2/StatusLabel.set("custom_colors/font_color", Color(0, 1, 0, 1))
	$MarginContainer/HBoxContainer/VBoxContainer2/StatusLabel.text = "Server Available"


func display_unavailable():
	$MarginContainer/HBoxContainer/VBoxContainer2/StatusLabel.set("custom_colors/font_color", Color(1, 0, 0, 1))
	$MarginContainer/HBoxContainer/VBoxContainer2/StatusLabel.text = "Server Unavailable"
