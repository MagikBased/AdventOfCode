extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	for line in Main.lines:
		var parts = line.strip_edges().split("x") as Array
		for i in range(parts.size()):
			parts[i] = parts[i].to_int()
		parts.sort()
		silver += 3*parts[0]*parts[1] + 2*parts[1]*parts[2] + 2*parts[0]*parts[2]
		gold += 2*parts[0]+2*parts[1] + parts[0]*parts[1]*parts[2]
	print("Part One: ", silver)
	print("Part Two: ", gold)
