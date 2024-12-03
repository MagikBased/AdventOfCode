extends Node

var safe_reports = 0
var moderately_safe = 0

func _ready() -> void:
	for line in Main.lines:
		var parts = line.strip_edges().split(" ") as Array
		for i in range(parts.size()):
			parts[i] = parts[i].to_int()
		if check_report(parts):
			safe_reports +=1
		else:
			for i in range(parts.size()):
				var really_safe = parts.duplicate()
				really_safe.remove_at(i)
				if check_report(really_safe):
					moderately_safe += 1
					break
	print("Part One: ",safe_reports)
	print("Part Two: ", safe_reports + moderately_safe)

func check_report(parts):
	var direction = 0
	if parts[0] > parts[1]:
		direction = -1
	else:
		direction = 1

	for i in range(parts.size() - 1):
		if parts[i + 1] > parts[i] and direction == -1:
			return false
		elif parts[i + 1] < parts[i] and direction == 1:
			return false
		elif parts[i + 1] == parts[i]:
			return false
		if abs(parts[i] - parts[i + 1]) > 3:
			return false
	return true
