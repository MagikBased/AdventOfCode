extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	for line in Main.lines:
		var id_pairs = line.split(",")
		for pair in id_pairs:
			var ids = pair.split("-")
			var left := int(ids[0])
			var right := int(ids[1])
			var numbers_in_range = []
			for r in range(left, right + 1):
				numbers_in_range.append(r)
			for num in numbers_in_range:
				var s = str(num)
				#if (s.length() % 2 != 0):
					#continue
				if (s.length() % 2 == 0 and s.substr(0, s.length()/2) == s.substr(s.length()/2, s.length())):
					silver += num
				for i in range(2, s.length() + 1):
					if (s.length() % i == 0 and s.substr(0, (s.length() / i)).repeat(i) == s):
						gold += num
						break
	print("Part One: ", silver)
	print("Part Two: ", gold)
