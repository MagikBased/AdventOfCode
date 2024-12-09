extends Node

var silver = 0
var gold = 0
var operators = ["+", "*", "||"]

func _ready() -> void:
	for line in Main.lines:
		var parts = line.strip_edges().split(": ") as Array
		var target = parts[0].to_int()
		var numbers = parts[-1].strip_edges().split(" ") as Array
		for number in range(numbers.size()):
			numbers[number] = numbers[number].to_int()
		
		if test_formulas(numbers, target):
			#print("Target ", target, " can be achieved with numbers ", numbers)
			silver += target
		#else:
			#print("Target ", target, " cannot be achieved with numbers ", numbers)
	print("Part One: ", silver)
	print("Part Two: ", gold)
func test_formulas(numbers: Array, target: int) -> bool:
	for combination in get_operator_combinations(numbers.size() - 1):
		var result = evaluate_formula(numbers, combination)
		if result == target:
			#print("Match found: ", construct_formula(numbers, combination), " = ", target)
			return true
	return false

func construct_formula(numbers: Array) -> String:
	var formula = ""
	for i in range(numbers.size()):
		formula += str(numbers[i])
		if i < operators.size():
			formula += operators[i]
	return formula

func evaluate_formula(numbers: Array, possible_operators: Array) -> int:
	var result = numbers[0]
	for i in range(possible_operators.size()):
		var operator = possible_operators[i]
		var next_number = numbers[i + 1]
		if operator == "+":
			result += next_number
		elif operator == "*":
			result *= next_number
		elif operator == "||":
			result = concatenate_numbers(result, next_number)
	return result

func get_operator_combinations(count: int) -> Array:
	var combinations = []
	get_operator_combinations_recursive([], count, combinations)
	return combinations

func get_operator_combinations_recursive(current: Array, remaining: int, combinations: Array):
	if remaining == 0:
		combinations.append(current.duplicate())
	else:
		for operator in operators:
			var next = current.duplicate()
			next.append(operator)
			get_operator_combinations_recursive(next, remaining - 1, combinations)

func concatenate_numbers(a: int, b: int) -> int:
	var digits_in_b = int(floor(log(b) / log(10))) + 1
	return a * int(pow(10, digits_in_b)) + b
