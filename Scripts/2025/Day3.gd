extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	for line in Main.lines:
		var batteries = []
		for i in range(line.length() -1):
			batteries.append(line[i].to_int())
		var first_battery_value = batteries.max()
		var first_battery_index = batteries.find(first_battery_value)
		batteries = batteries.slice(first_battery_index + 1, batteries.size())
		batteries.append(line[line.length() - 1].to_int())
		var second_battery_value = batteries.max()
		var max_joltage = first_battery_value * 10 + second_battery_value
		silver += max_joltage
		
		batteries = []
		max_joltage = 0
		for i in range(line.length()):
			batteries.append(line[i].to_int())
		for i in range(11):
			var number = (batteries.slice(0, i - 11)).max()
			var index = batteries.find(number)
			batteries = batteries.slice(index + 1, batteries.size())
			max_joltage = (max_joltage * 10) + number
		max_joltage = (max_joltage * 10) + batteries.max()
		gold += max_joltage
		
	print("Part One: ", silver)
	print("Part Two: ", gold)
