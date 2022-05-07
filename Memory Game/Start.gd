extends Control

func _on_ModeSelectHUD_openStart():
	show()
func _on_GameUI_openStart():
	show()

signal openModeSelect
func _on_StartGameButton_pressed():
	hide()
	emit_signal("openModeSelect")

signal openHowToPlay
func _on_HowToPlayButton_pressed():
	emit_signal("openHowToPlay")

func _on_ExitButton_pressed():
	$Dimmer.show()
	$ExitWindow.popup()

func _closeExitPopup():
	$Dimmer.hide()
	$ExitWindow.hide()
func _on_NoButton_pressed():
	_closeExitPopup()
func _on_YesButton_pressed():
	get_tree().quit()
func _on_ExitWindow_popup_hide():
	_closeExitPopup()
