extends Node2D

var input_path = "res://Inputs/input_day_1.txt"
var input = FileAccess.open(input_path,FileAccess.READ)
var lines = []
var current_year = 2024
var day_functions = {}


func load_day_functions(year):
	var year_path = "res://Scripts/" + str(year) + "/"
	for day in range(1,26):
		var script_path = year_path + "Day" + str(day) + ".gd"
		if FileAccess.file_exists(script_path):
			day_functions[day] = load(script_path).new()

func day_1():
	read_lines_from_file(1)
	var script_path = "res://Scripts/%d/Day%d.gd" % [current_year, 1]
	if FileAccess.file_exists(script_path):
		var day_script = load(script_path).new()
		day_script._ready()
		
	#print("Part One: " + str(sum_of_first_and_last_numbers(lines)))
	#print("Part Two: " + str(sum_of_first_and_last_numbers(find_first_and_last_numbers_with_spelling())))
func day_2():
	read_lines_from_file(2)
	var script_path = "res://Scripts/%d/Day%d.gd" % [current_year, 2]
	if FileAccess.file_exists(script_path):
		var day_script = load(script_path).new()
		day_script._ready()
func day_3():
	read_lines_from_file(3)
	var script_path = "res://Scripts/%d/Day%d.gd" % [current_year, 3]
	if FileAccess.file_exists(script_path):
		var day_script = load(script_path).new()
		day_script._ready()
func day_4():
	read_lines_from_file(4)
	print("Function not found")
func day_5():
	read_lines_from_file(5)
	print("Function not found")
func day_6():
	read_lines_from_file(6)
	print("Function not found")
func day_7():
	read_lines_from_file(7)
	print("Function not found")
func day_8():
	read_lines_from_file(8)
	print("Function not found")
func day_9():
	read_lines_from_file(9)
	print("Function not found")
func day_10():
	read_lines_from_file(10)
	print("Function not found")
func day_11():
	read_lines_from_file(1)
	print("Function not found")
func day_12():
	read_lines_from_file(12)
	print("Function not found")
func day_13():
	read_lines_from_file(13)
	print("Function not found")
func day_14():
	read_lines_from_file(14)
	print("Function not found")
func day_15():
	read_lines_from_file(15)
	print("Function not found")
func day_16():
	read_lines_from_file(16)
	print("Function not found")
func day_17():
	read_lines_from_file(17)
	print("Function not found")
func day_18():
	read_lines_from_file(18)
	print("Function not found")
func day_19():
	read_lines_from_file(19)
	print("Function not found")
func day_20():
	read_lines_from_file(20)
	print("Function not found")
func day_21():
	read_lines_from_file(21)
	print("Function not found")
func day_22():
	read_lines_from_file(22)
	print("Function not found")
func day_23():
	read_lines_from_file(23)
	print("Function not found")
func day_24():
	read_lines_from_file(24)
	print("Function not found")
func day_25():
	read_lines_from_file(25)
	print("Function not found")

func read_lines_from_file(day):
	input_path = "res://Inputs/" + str(current_year) +"/input_day_" + str(day) + ".txt"
	input = FileAccess.open(input_path,FileAccess.READ)
	lines.clear()
	#print(input_path)
	while not input.eof_reached():
		lines.append(input.get_line())
	input.close()
	var non_empty_lines = []
	for line in lines:
		if not line.is_empty():
			non_empty_lines.append(line)
	lines = non_empty_lines
	
func sum_of_first_and_last_numbers(lineInput):
	var total: int = 0
	for line in lineInput:
		var firstNumber: int
		var lastNumber: int
		var numbersOnly = line.to_int()
		var numbersOnlyString = str(numbersOnly)
		firstNumber = int(numbersOnlyString[0])
		lastNumber = numbersOnly % 10
		var combinedNumber = str(firstNumber) + str(lastNumber)
		combinedNumber = combinedNumber.to_int()
		total += combinedNumber
	return total

func find_first_and_last_numbers_with_spelling():
	var newLines = []
	for line in lines:
		line = spelling_replacement(line)
		newLines.append(line)
	return newLines

func spelling_replacement(line: String) -> String:
	if line.contains("one"):
		line = line.replace("one","o1ne")
	if line.contains("two"):
		line = line.replace("two","t2wo")
	if line.contains("three"):
		line = line.replace("three","t3hree")
	if line.contains("four"):
		line = line.replace("four","f4our")
	if line.contains("five"):
		line = line.replace("five","f5ive")
	if line.contains("six"):
		line = line.replace("six","s6ix")
	if line.contains("seven"):
		line = line.replace("seven","s7even")
	if line.contains("eight"):
		line = line.replace("eight","e8ight")
	if line.contains("nine"):
		line = line.replace("nine","n9ine")
	return line

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
	
	for line in lines:
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
				
	for line in lines:
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
	
	for line in lines:
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
	
	for line in lines:
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
	
	for line in lines:
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
	
	for line in lines:
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
