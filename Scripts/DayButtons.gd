extends Control

var red = Color(1,0,0)
var green = Color(0,1,0)

func _ready():
	var grid = $GridContainer  # Replace with your GridContainer's path
	grid.columns = 5

	for buttonNumber in range(1, 26):
		var button = Button.new()
		button.text = str(buttonNumber)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		if buttonNumber % 2 == 0:
			button.modulate = red
		else:
			button.modulate = green
		var callable = Callable(self, "_on_Button_pressed").bind(buttonNumber)
		button.connect("pressed", callable)
		grid.add_child(button)

func _on_Button_pressed(button_number):
	var function_name = "day_" + str(button_number)
	if Main.has_method(function_name):
		Main.call(function_name)
	else:
		print("Function not found")
