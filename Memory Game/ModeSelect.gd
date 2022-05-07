extends Control

func _on_StartingHUD_openModeSelect():
	show()
func _on_GameUI_openModeSelect():
	show()

signal open_inOrder
signal open_reverse
signal open_ascending
signal open_descending
signal open_positional
signal open_levelled
func _openGame(mode):
	hide()
	if mode == "In Order":
		emit_signal("open_inOrder")
	elif mode == "Reverse":
		emit_signal("open_reverse")
	elif mode == "Ascending":
		emit_signal("open_ascending")
	elif mode == "Descending":
		emit_signal("open_descending")
	elif mode == "Positional":
		emit_signal("open_positional")
	elif mode == "Levelled":
		emit_signal("open_levelled")

func _on_InOrderButton_pressed():
	_openGame("In Order")
func _on_ReverseButton_pressed():
	_openGame("Reverse")
func _on_AscendingButton_pressed():
	_openGame("Ascending")
func _on_DescendingButton_pressed():
	_openGame("Descending")
func _on_PositionalButton_pressed():
	_openGame("Positional")
func _on_LevelledButton_pressed():
	_openGame("Levelled")

signal openStart
func _on_BackButton_pressed():
	hide()
	emit_signal("openStart")
