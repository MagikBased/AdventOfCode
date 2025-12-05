extends Control

var red = Color(1,0,0,1)
var green = Color(0,1,0,1)

var results_ui_scene = preload("res://Scenes/results_ui.tscn")

func _ready():
	var grid = $GridContainer
	grid.columns = 5
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.size_flags_vertical = Control.SIZE_EXPAND_FILL

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

func _notification(what):
	if what == NOTIFICATION_RESIZED:
		adjust_button_sizes()

func adjust_button_sizes():
	var grid = $GridContainer
	for child in grid.get_children():
		if child is Button:
			child.rect_min_size = Vector2(0, 0)

func _on_Button_pressed(day_number):
	var results_ui = results_ui_scene.instantiate()
	get_parent().add_child(results_ui)
	Main.call("execute_day", day_number)
