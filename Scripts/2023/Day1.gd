extends Node

#
#func read_lines_from_file(day):
	#input_path = "res://Inputs/" + str(year) +"/input_day_" + str(day) + ".txt"
	#input = FileAccess.open(input_path,FileAccess.READ)
	#lines.clear()
	#print(input_path)
	#while not input.eof_reached():
		#lines.append(input.get_line())
	#input.close()
	#var non_empty_lines = []
	#for line in lines:
		#if not line.is_empty():
			#non_empty_lines.append(line)
	#lines = non_empty_lines


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
	for line in Main.lines:
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
