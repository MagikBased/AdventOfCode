extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	var i = 0
	for line in Main.lines:
		for chr in line.strip_edges():
			i += 1
			if chr == "(":
				silver += 1
			elif chr == ")":
				silver -= 1
				if silver == -1 and gold == 0:
					gold = i

	print("Part One: ", silver)
	print("Part Two: ", gold)
