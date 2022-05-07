extends Control

func _on_StartingUI_openHowToPlay():
	show()
	$DisplayWindow.popup()
func _on_GameUI_openHowToPlay():
	show()
	$DisplayWindow.popup()

func _on_DoneButton_pressed():
	$DisplayWindow.hide()
	hide()
func _on_NextButton_pressed():
	if $DisplayWindow/NextButton.text == ">":
		$DisplayWindow/Text1.hide()
		$DisplayWindow/Text2.show()
		$DisplayWindow/NextButton.text = "<"
	else:
		$DisplayWindow/Text2.hide()
		$DisplayWindow/Text1.show()
		$DisplayWindow/NextButton.text = ">"
func _on_DisplayWindow_popup_hide():
	$DisplayWindow.hide()
	hide()
