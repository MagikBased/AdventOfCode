extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	var pos := 50
	for line in Main.lines:
		var dir = line[0]
		var amount = line.substr(1).to_int()
		gold += amount / 100
		amount %= 100
		
		if dir == "R":
			pos += amount
		else:
			pos -= amount
		if pos >= 100:
			gold += pos / 100
			pos %= 100
		elif pos < 0:
			gold += abs(pos / 100) + 1
			pos += 100
		if pos == 0:
			silver += 1
	print("Part One: ", silver)
	print("Part Two: ", gold)
