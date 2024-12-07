extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	var mul_regex = RegEx.new()
	var do_regex = RegEx.new()
	var dont_regex = RegEx.new()
	
	var mul_pattern = "mul\\s*\\((\\d+),(\\d+)\\)"
	var do_pattern = "do\\(\\)"
	var dont_pattern = "don\\'t\\(\\)"
	
	if mul_regex.compile(mul_pattern) != OK or do_regex.compile(do_pattern) != OK or dont_regex.compile(dont_pattern) != OK:
		print("Regex compile error")
		return

	var multiply = 1 
	for line in Main.lines:
		var index = 0
		while index < line.length():
			var do_match = do_regex.search(line, index)
			if do_match and do_match.get_start() == index:
				multiply = 1
				index = do_match.get_end()
				continue
			var dont_match = dont_regex.search(line, index)
			if dont_match and dont_match.get_start() == index:
				multiply = 0
				index = dont_match.get_end()
				continue
			var mul_match = mul_regex.search(line, index)
			if mul_match and mul_match.get_start() == index:
				var x = mul_match.get_string(1).to_int()
				var y = mul_match.get_string(2).to_int()
				silver += x * y
				gold += x * y * multiply
				index = mul_match.get_end()
				continue
			index += 1
	print("Part One: ", silver)
	print("Part Two: ", gold)
