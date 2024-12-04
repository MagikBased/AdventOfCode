extends Node


func _ready() -> void:
	pass 

func cube_count():
	var min_red = 0
	var min_green = 0
	var min_blue = 0
	
	var max_red = 12
	var max_green = 13
	var max_blue = 14
	
	var red_in_line = []
	var green_in_line = []
	var blue_in_line = []
	
	var max_red_in_line = []
	var max_green_in_line = []
	var max_blue_in_line = []
	
	var regex_red = RegEx.new()
	var regex_green = RegEx.new()
	var regex_blue = RegEx.new()
	var game_sum = 0
	regex_red.compile("(\\d+)\\s*red")
	regex_green.compile("(\\d+)\\s*green")
	regex_blue.compile("(\\d+)\\s*blue")

	var line_number = 0
	
	for line in Main.lines:
		line_number += 1
		var start_position_red = 0
		while true:
			var result_red = regex_red.search(line, start_position_red)
			if result_red:
				if int(result_red.get_string(1)) > max_red:
					for i in range(red_in_line.size() - 1, -1, -1): 
						if red_in_line[i] == line_number:
							red_in_line.remove_at(i)
					break
				else:
					if line_number not in red_in_line:
						red_in_line.append(line_number)
				start_position_red = result_red.get_end()
			else:
				break
	line_number = 0
				
	for line in Main.lines:
		line_number += 1
		var start_position_red = 0
		while true:
			var result_red = regex_red.search(line, start_position_red)
			if result_red:
				if int(result_red.get_string(1)) > min_red:
					min_red = int(result_red.get_string(1))
				start_position_red = result_red.get_end()
			else:
				max_red_in_line.append(min_red)
				min_red = 0
				break
	line_number = 0
	
	for line in Main.lines:
		line_number += 1
		var start_position_green = 0
		while true:
			var result_green = regex_green.search(line, start_position_green)
			if result_green:
				if int(result_green.get_string(1)) > max_green:
					for i in range(green_in_line.size() - 1, -1, -1): 
						if green_in_line[i] == line_number:
							green_in_line.remove_at(i)
					break
				else:
					if line_number not in green_in_line:
						green_in_line.append(line_number)
				start_position_green = result_green.get_end()
			else:
				break
	line_number = 0
	
	for line in Main.lines:
		line_number += 1
		var start_position_green = 0
		while true:
			var result_green = regex_green.search(line, start_position_green)
			if result_green:
				if int(result_green.get_string(1)) > min_green:
					min_green = int(result_green.get_string(1))
				start_position_green = result_green.get_end()
			else:
				max_green_in_line.append(min_green)
				min_green = 0
				break
	line_number = 0
	
	for line in Main.lines:
		line_number += 1
		var start_position_blue = 0
		while true:
			var result_blue = regex_blue.search(line, start_position_blue)
			if result_blue:
				if int(result_blue.get_string(1)) > max_blue:
					for i in range(blue_in_line.size() - 1, -1, -1): 
						if blue_in_line[i] == line_number:
							blue_in_line.remove_at(i)
					break
				else:
					if line_number not in blue_in_line:
						blue_in_line.append(line_number)
				start_position_blue = result_blue.get_end()
			else:
				break
	line_number = 0
	
	for line in Main.lines:
		line_number += 1
		var start_position_blue = 0
		while true:
			var result_blue = regex_blue.search(line, start_position_blue)
			if result_blue:
				if int(result_blue.get_string(1)) > min_blue:
					min_blue = int(result_blue.get_string(1))
				start_position_blue = result_blue.get_end()
			else:
				max_blue_in_line.append(min_blue)
				min_blue = 0
				break
	line_number = 0
	
	for count in (len(red_in_line)):
		if red_in_line[count] in blue_in_line and red_in_line[count] in green_in_line:
			game_sum += red_in_line[count]
	print("Part One: " + str(game_sum))
	if max_red_in_line.size() == max_green_in_line.size() and max_red_in_line.size() == max_blue_in_line.size():
		var power_sum = 0
		for count in max_red_in_line.size():
			power_sum += max_red_in_line[count] * max_green_in_line[count] * max_blue_in_line[count]
		print("Part Two: " + str(power_sum))
