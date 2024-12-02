extends Control

var red = Color(1,0,0)
var green = Color(0,1,0)

var current_year = 2024

func _ready():
	var grid = $GridContainer
	grid.columns = 5

	for button_number in range(1, 26):
		var button = Button.new()
		button.text = str(button_number)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		if button_number % 2 == 0:
			button.modulate = red
		else:
			button.modulate = green
		var callable = Callable(self, "_on_Button_pressed").bind(button_number)
		button.connect("pressed", callable)
		grid.add_child(button)

func _on_Button_pressed(day_number):
	#var script_path = "res://Scripts/%d/Day%d.gd" % [current_year, day_number]
	var function_name = "day_" + str(day_number)
	if Main.has_method(function_name):
		Main.call(function_name)
	else:
		print("Function not found")
