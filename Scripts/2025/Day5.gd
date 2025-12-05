extends Node

var silver := 0
var gold := 0
var ranges: Array = []

func _ready() -> void:
	var input_sections = [[]]
	for line in Main.lines:
		if line.is_empty():
			input_sections.append([])
		else:
			input_sections[-1].append(line.strip_edges())

	for rng in input_sections[0]:
		var parts := rng.strip_edges().split("-") as Array
		var left := int(parts[0])
		var right := int(parts[1])
		ranges.append([left, right])
		
	ranges.sort()
	#print(ranges)

	var new_ranges = []
	new_ranges.append(ranges[0])

	for i in range(1, ranges.size()):
		var rng = ranges[i]
		var last = new_ranges[-1]
		var last_end = last[1]
		if rng[0] <= last_end:
			new_ranges[-1][1] = max(last_end, rng[1])
		else:
			new_ranges.append(rng)
	#print(new_ranges)
	
	for rng in new_ranges:
		gold += rng[1] - rng[0] + 1
	
	for id_str in input_sections[1]:
		var key := int(id_str)
		if is_in_a_range(key):
			silver += 1

	print("Part One: ", silver)
	print("Part Two: ", gold)

func is_in_a_range(x: int) -> bool:
	for r in ranges:
		if x >= r[0] and x <= r[1]:
			return true
	return false

#gold attempted: 348115673841739, too high
				#348115673841738, too high
#				4283199064, too low
