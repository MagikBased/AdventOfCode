extends Control

var red = Color(1,0,0)
var green = Color(0,1,0)

var current_year = 2024
var results_ui_scene = preload("res://Scenes/results_ui.tscn")


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
	var results_ui = results_ui_scene.instantiate()
	get_parent().add_child(results_ui)
	var function_name = "day_" + str(day_number)
	if Main.has_method(function_name):
		Main.call(function_name)
	else:
		print("Function not found")
