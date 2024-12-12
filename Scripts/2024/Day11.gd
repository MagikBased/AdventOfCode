extends Node

var silver = 0
var gold = 0

var cache = {}

func _ready() -> void:
	var stones = Main.lines[0].split(" ") as Array
	for i in range(stones.size()):
		stones[i] = stones[i].to_int()
	for stone in stones:
		silver += blink(stone, cache, 25)
		gold += blink(stone, cache, 75)
	print("Part One: ", silver)
	print("Part Two: ", gold)

func blink(num: int, input_cache: Dictionary, ans: int) -> int:
	if ans == 0:
		return 1
	if input_cache.has([num, ans]):
		return input_cache[[num, ans]]
	var total = 0
	var number_string = str(num)
	if num == 0:
		var value = blink(1, input_cache, ans - 1)
		total += value
		input_cache.get_or_add([num, ans], value)
	elif number_string.length() % 2 == 0:
		var left_number = number_string.substr(0, number_string.length() / 2).to_int()
		var right_number = number_string.substr(number_string.length() / 2).to_int()
		var value = 0
		value += blink(left_number, input_cache, ans - 1)
		value += blink(right_number, input_cache, ans - 1)
		total += value
		input_cache.get_or_add([num, ans], value)
	else:
		var value = blink(num * 2024, input_cache, ans - 1)
		total += value
		input_cache.get_or_add([num, ans], value)
	return total
