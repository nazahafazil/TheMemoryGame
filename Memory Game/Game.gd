extends Control

signal openStart
signal openModeSelect
signal openHowToPlay

func _openGameUI():
	show()
	$DisplayWindow/StartingMessageLabel.show()
	$DisplayWindow/TimeMessageLabel.hide()
	$NumberClock.stop()
	$CountdownTimer.stop()
	$AnswerTimer.stop()
func _closeGameUI():
	hide()
	$NumberClock.stop()
	$CountdownTimer.stop()
	$AnswerTimer.stop()

func _ready():
	randomize()
	$StartSubmitButton.text = "Start Game"
	$AnswerTextBox.text = ""
	if $DigitLabel/NumberOfDigits.text != "Random":
		$DigitSlider.editable = true
	else:
		digits = randi() % 9 + 1
	if $TitleLabel/CurrentMode.text == "Levelled":
		$DigitLabel.hide()
		$DigitSlider.hide()
		$RandomizeCheckBox.hide()
		$ModeSelectorLabel.show()
	$SpeedSlider.editable = true
	$DisplayWindow/DisplayNumberLabel.text = ""
	$DisplayWindow/TimeMessageLabel.set("custom_colors/font_color", Color(0.854901, 0.313725, 0.313725, 1))
	$DisplayWindow/TimeMessageLabel.text = "Enter the\nnumbers\nbefore the\ntime runs out!"
	$AnswerTextBox/ResetPoints.disabled = false
	$RandomizeCheckBox.disabled = false
	$TimerLabel/Tens.set("custom_colors/font_color", Color(1,1,1,1))
	$TimerLabel/Ones.set("custom_colors/font_color", Color(1,1,1,1))
	$TimerLabel/Tens.readonly = false
	$TimerLabel/Ones.readonly = false
	$TimerLabel/Tens.text = " " + str(tens)
	$TimerLabel/Ones.text = " " + str(ones)
	$BackToStartButton.disabled = false
	$ModeSelectButton.disabled = false
	$HowToPlayButton.disabled = false
	$ModeSelectorLabel/InOrderCheckBox.disabled = false
	$ModeSelectorLabel/ReverseCheckBox.disabled = false
	$ModeSelectorLabel/AscendingCheckBox.disabled = false
	$ModeSelectorLabel/DescendingCheckBox.disabled = false
	$ModeSelectorLabel/PositionalCheckBox.disabled = false
	$ModeSelectorLabel/AllModesCheckBox.disabled = false
	counter = 0
	lines = 0
	count = 0
	number = 0
	prevNumber = -1
	timecount = 0
	numberString = ""
	numberList = [0]
	modeListSelection = ""

func onlyMode(mode):
	$TitleLabel/CurrentMode.text = mode
	$AnswerTextBox/PointsLabel.text = "POINTS:"
	$DigitLabel.show()
	$DigitSlider.show()
	$RandomizeCheckBox.show()
	$ModeSelectorLabel.hide()
	_openGameUI()
	_ready()

func _on_ModeSelectHUD_open_inOrder():
	onlyMode("In Order")
func _on_ModeSelectHUD_open_reverse():
	onlyMode("Reverse")
func _on_ModeSelectHUD_open_ascending():
	onlyMode("Ascending")
func _on_ModeSelectHUD_open_descending():
	onlyMode("Descending")
func _on_ModeSelectHUD_open_positional():
	onlyMode("Positional")
func _on_ModeSelectHUD_open_levelled():
	onlyMode("Levelled")
	$AnswerTextBox/PointsLabel.text = "SCORE:"
	$DigitLabel.hide()
	$DigitSlider.hide()
	$RandomizeCheckBox.hide()
	$ModeSelectorLabel.show()

func _on_BackToStartButton_pressed():
	_closeGameUI()
	if $BackToStartButton.text == "Back to Start":
		emit_signal("openStart")
	elif $BackToStartButton.text == "Puzzle Selection":
		emit_signal("openPuzzleSelect")
func _on_ModeSelectButton_pressed():
	_closeGameUI()
	emit_signal("openModeSelect")
func _on_ResetPoints_pressed():
	$AnswerTextBox/CurrentPoints.text = "0"
func _on_HowToPlayButton_pressed():
	emit_signal("openHowToPlay")

func _on_DigitSlider_value_changed(value):
	digits = value
	$DigitLabel/NumberOfDigits.text = str(value)
func _on_SpeedSlider_value_changed(value):
	if value == 1:
		$NumberClock.wait_time = 1.3
		$SpeedLabel/CurrentSpeed.text = "Slow"
	elif value == 2:
		$NumberClock.wait_time = 1
		$SpeedLabel/CurrentSpeed.text = "Normal"
	elif value == 3:
		$NumberClock.wait_time = 0.5
		$SpeedLabel/CurrentSpeed.text = "Fast"
func _on_RandomizeCheckBox_toggled(button_pressed):
	if button_pressed == true:
		digits = randi() % 9 + 1
		$DigitLabel/NumberOfDigits.text = "Random"
		$DigitLabel.set("rect_position", Vector2(17, 246))
		$DigitSlider.editable = false
	elif button_pressed == false:
		digits = $DigitSlider.value
		$DigitLabel/NumberOfDigits.text = str(digits)
		$DigitLabel.set("rect_position", Vector2(66, 246))
		$DigitSlider.editable = true

func _on_Tens_text_changed():
	if !($TimerLabel/Tens.readonly):
		tens = int($TimerLabel/Tens.text)
func _on_Ones_text_changed():
	if !($TimerLabel/Tens.readonly):
		ones = int($TimerLabel/Ones.text)

func _on_StartSubmitButton_pressed():
	if $StartSubmitButton.text == "Start Game":
		$StartSubmitButton.disabled = true
		$BackToStartButton.disabled = true
		$ModeSelectButton.disabled = true
		$HowToPlayButton.disabled = true
		$RandomizeCheckBox.disabled = true
		$ModeSelectorLabel/InOrderCheckBox.disabled = true
		$ModeSelectorLabel/ReverseCheckBox.disabled = true
		$ModeSelectorLabel/AscendingCheckBox.disabled = true
		$ModeSelectorLabel/DescendingCheckBox.disabled = true
		$ModeSelectorLabel/PositionalCheckBox.disabled = true
		$ModeSelectorLabel/AllModesCheckBox.disabled = true
		$AnswerTextBox/ResetPoints.disabled = true
		$DisplayWindow/StartingMessageLabel.hide()
		$DisplayWindow/DisplayNumberLabel.show()
		$DigitSlider.editable = false
		$SpeedSlider.editable = false
		$DisplayWindow/ReadySetGo.max_lines_visible = 0
		$TimerLabel/Tens.readonly = true
		$TimerLabel/Ones.readonly = true
		$TimerLabel/Tens.set("custom_colors/font_color_readonly", Color(1, 1, 1, 1))
		$TimerLabel/Ones.set("custom_colors/font_color_readonly", Color(1, 1, 1, 1))
		$TimerLabel/Tens.text = " " + str(tens)
		$TimerLabel/Ones.text = " " + str(ones)
		if $TitleLabel/CurrentMode.text == "Levelled":
			$DisplayWindow/LevelLabel/CurrentLevelLabel.text = str(int($DisplayWindow/LevelLabel/CurrentLevelLabel.text) + 1)
			digits = int($DisplayWindow/LevelLabel/CurrentLevelLabel.text)
			$DisplayWindow/LevelLabel.show()
			$DisplayWindow/LevelLabel/CurrentLevelLabel.show()
			$PuzzleCountdownTimer.start()
		else:
			$CountdownTimer.start()
	elif $StartSubmitButton.text == "Submit":
		$BackToStartButton.disabled = false
		$ModeSelectButton.disabled = false
		$HowToPlayButton.disabled = false
		$AnswerTextBox/ResetPoints.disabled = false
		$AnswerTextBox.readonly = true
		if $TitleLabel/CurrentMode.text == "Levelled" && digits < 10:
			$StartSubmitButton.text = "Continue"
		else:
			$StartSubmitButton.text = "Play Again!"
		$AnswerTimer.stop()
		if numberString == $AnswerTextBox.text:
			$AnswerTextBox.text = " Correct!"
			$DisplayWindow/TimeMessageLabel.set("custom_colors/font_color", Color(0.501961,0.819608,0.392156,1))
			$TimerLabel/Tens.set("custom_colors/font_color_readonly", Color(0.501961,0.819608,0.392156,1))
			$TimerLabel/Ones.set("custom_colors/font_color_readonly", Color(0.501961,0.819608,0.392156,1))
			if digits == 1 || $TitleLabel/CurrentMode.text == "Positional" || modeListSelection == "Positional":
				$DisplayWindow/TimeMessageLabel.text = "You got\nthe number\ncorrect!"
			elif $TitleLabel/CurrentMode.text == "Levelled" && digits == 9:
				$DisplayWindow/TimeMessageLabel.text = "Congrats!\nYou beat\nlevelled\nmode!"
			else:
				$DisplayWindow/TimeMessageLabel.text = "You got\nthe numbers\ncorrect!"
			if $TitleLabel/CurrentMode.text == "Levelled" && digits < 9:
				$StartSubmitButton.text = "Continue"
			else:
				$StartSubmitButton.text = "Play Again!"
			$AnswerTextBox/CurrentPoints.text = str(int($AnswerTextBox/CurrentPoints.text) + 1)
		else:
			$AnswerTextBox.text = " Try again!"
			$StartSubmitButton.text = "Play Again!"
			if digits == 1 || $TitleLabel/CurrentMode.text == "Positional" || modeListSelection == "Positional":
				$DisplayWindow/TimeMessageLabel.text = "You got\nthe number\nincorrect!"
			else:
				$DisplayWindow/TimeMessageLabel.text = "You got\nthe numbers\nincorrect!"
	elif $StartSubmitButton.text == "Continue":
		_ready()
		_openGameUI()
	elif $StartSubmitButton.text == "Play Again!":
		_ready()
		_openGameUI()
		if $TitleLabel/CurrentMode.text == "Levelled":
			$DisplayWindow/LevelLabel/CurrentLevelLabel.text = "0"
			$AnswerTextBox/CurrentPoints.text = "0"

func _on_PuzzleCountdownTimer_timeout():
	$DisplayWindow/LevelLabel.hide()
	$DisplayWindow/LevelLabel/CurrentLevelLabel.hide()
	$PuzzleCountdownTimer.stop()
	$CountdownTimer.start()

var lines = 0
var counter = 0
func _on_CountdownTimer_timeout():
	if counter == 3:
		$DisplayWindow/ReadySetGo.hide()
		$StartSubmitButton.hide()
		if $TitleLabel/CurrentMode.text == "Levelled":
			modeListSelection = modeList[int(rand_range(0, modeList.size() - 1))]
		$NumberClock.start()
		$CountdownTimer.stop()
	else:
		lines = lines + 1
		$DisplayWindow/ReadySetGo.max_lines_visible = lines
		$DisplayWindow/ReadySetGo.show()
		counter = counter + 1

var count = 0
var number = 0
var prevNumber = -1 
var digits = 4
var numberString = ""
var numberList = [0]
var randomPosition = 0
var modeListSelection = ""
func _on_NumberClock_timeout():
	if count == digits:
		if digits == 1:
			$DisplayWindow/TimeMessageLabel.text = "Enter the\nnumber!"
		elif $TitleLabel/CurrentMode.text == "In Order" || modeListSelection == "In Order":
			$DisplayWindow/TimeMessageLabel.text = "Enter the\nnumbers\nin order!"
		elif $TitleLabel/CurrentMode.text == "Reverse" || modeListSelection == "Reverse":
			$DisplayWindow/TimeMessageLabel.text = "Enter the\nnumbers in\nreverse\norder!"
		elif $TitleLabel/CurrentMode.text == "Ascending" || modeListSelection == "Ascending":
			$DisplayWindow/TimeMessageLabel.text = "Enter the\nnumbers in\nascending\norder!"
			numberList.sort()
			for i in range(1, digits+1, 1):
				numberString = numberString + str(numberList[i])
		elif $TitleLabel/CurrentMode.text == "Descending" || modeListSelection == "Descending":
			$DisplayWindow/TimeMessageLabel.text = "Enter the\nnumbers in\ndescending\norder!"
			numberList.sort()
			for i in range(1, digits+1, 1):
				numberString = str(numberList[i]) + numberString
		if $TitleLabel/CurrentMode.text == "Positional" || modeListSelection == "Positional":
			randomPosition = int(rand_range(1, digits))
			if randomPosition == 1:
				if digits == 1:
					$DisplayWindow/TimeMessageLabel.text = "What\nwas the\nnumber?"
				else:
					$DisplayWindow/TimeMessageLabel.text = "What was\nthe 1st\nnumber?"
			elif randomPosition == 2:
				$DisplayWindow/TimeMessageLabel.text = "What was\nthe 2nd\nnumber?"
			elif randomPosition == 3:
				$DisplayWindow/TimeMessageLabel.text = "What was\nthe 3rd\nnumber?"
			else:
				$DisplayWindow/TimeMessageLabel.text = "What was\nthe " + str(randomPosition) + "th\nnumber?"
			numberString = str(numberList[randomPosition])
		$DisplayWindow/DisplayNumberLabel.hide()
		$DisplayWindow/TimeMessageLabel.show()
		$StartSubmitButton.text = "Submit"
		$StartSubmitButton.disabled = false
		$StartSubmitButton.show()
		$AnswerTextBox.readonly = false
		$TimerLabel/Tens.set("custom_colors/font_color_readonly", Color(1,1,1,1))
		$TimerLabel/Ones.set("custom_colors/font_color_readonly", Color(1,1,1,1))
		$AnswerTimer.start()
		$NumberClock.stop()
	else:
		number = randi() % 9
		while prevNumber == number:
			number = randi() % 9
		if $TitleLabel/CurrentMode.text == "In Order" || modeListSelection == "In Order":
			numberString = numberString + str(number)
		elif $TitleLabel/CurrentMode.text == "Reverse" || modeListSelection == "Reverse":
			numberString = str(number) + numberString
		elif $TitleLabel/CurrentMode.text == "Ascending" || $TitleLabel/CurrentMode.text == "Descending" || $TitleLabel/CurrentMode.text == "Positional" || modeListSelection == "Ascending" || modeListSelection == "Descending"  || modeListSelection == "Positional":
			numberList.push_back(number)
		$DisplayWindow/DisplayNumberLabel.text = str(number)
		prevNumber = number
		count = count + 1

var timecount = 0
var tens = 1
var ones = 0
func _on_AnswerTimer_timeout():
	if timecount % 2 == 1:
		$TimerLabel/Tens.set("custom_colors/font_color_readonly", Color(1,1,1,1))
		$TimerLabel/Ones.set("custom_colors/font_color_readonly", Color(1,1,1,1))
		timecount = timecount + 1
	elif timecount % 2 == 0:
		$TimerLabel/Tens.set("custom_colors/font_color_readonly", Color(0.854902, 0.305882, 0.305882, 1))
		$TimerLabel/Ones.set("custom_colors/font_color_readonly", Color(0.854902, 0.305882, 0.305882, 1))
		if int($TimerLabel/Ones.text) > 0:
			$TimerLabel/Ones.text = " " + str(int($TimerLabel/Ones.text) - 1)
		elif int($TimerLabel/Ones.text) == 0:
			if int($TimerLabel/Tens.text) > 0:
				$TimerLabel/Ones.text = " 9"
				$TimerLabel/Tens.text = " " + str(int($TimerLabel/Tens.text) - 1)
			elif int($TimerLabel/Tens.text) == 0:
				$TimerLabel/Tens.set("custom_colors/font_color_readonly", Color(0.854902, 0.305882, 0.305882, 1))
				$TimerLabel/Ones.set("custom_colors/font_color_readonly", Color(0.854902, 0.305882, 0.305882, 1))
				$AnswerTextBox.readonly = true
				$AnswerTextBox.text = "Try again!"
				$DisplayWindow/TimeMessageLabel.text = "You ran\nout of time!"
				$StartSubmitButton.text = "Play Again!"
				$AnswerTimer.stop()
		timecount = timecount + 1

var modeList = []
func _on_InOrderCheckBox_toggled(button_pressed):
	if button_pressed == true:
		modeList.append("In Order")
	else:
		modeList.remove("In Order")
func _on_ReverseCheckBox_toggled(button_pressed):
	if button_pressed == true:
		modeList.append("Reverse")
	else:
		modeList.remove("Reverse")
func _on_AscendingCheckBox_toggled(button_pressed):
	if button_pressed == true:
		modeList.append("Ascending")
	else:
		modeList.remove("Ascending")
func _on_DescendingCheckBox_toggled(button_pressed):
	if button_pressed == true:
		modeList.append("Descending")
	else:
		modeList.remove("Descending")
func _on_PositionalCheckBox_toggled(button_pressed):
	if button_pressed == true:
		modeList.append("Positional")
	else:
		modeList.remove("Positional")
func _on_AllModesCheckBox_toggled(button_pressed):
	if button_pressed == true:
		$ModeSelectorLabel/InOrderCheckBox.pressed = true
		$ModeSelectorLabel/ReverseCheckBox.pressed = true
		$ModeSelectorLabel/AscendingCheckBox.pressed = true
		$ModeSelectorLabel/DescendingCheckBox.pressed = true
		$ModeSelectorLabel/PositionalCheckBox.pressed = true
	else:
		$ModeSelectorLabel/InOrderCheckBox.pressed = false
		$ModeSelectorLabel/ReverseCheckBox.pressed = false
		$ModeSelectorLabel/AscendingCheckBox.pressed = false
		$ModeSelectorLabel/DescendingCheckBox.pressed = false
		$ModeSelectorLabel/PositionalCheckBox.pressed = false

