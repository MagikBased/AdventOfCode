extends Node

var safe_reports = 0

func _ready() -> void:
	var n = 1
	for line in Main.lines:
		var parts = line.strip_edges().split(" ") as Array
		for i in range(parts.size()):
			parts[i] = parts[i].to_int()
		#print(parts)
		var invalid_index = -1
		invalid_index = check_report(parts, false)
		#print("safe reports: ",safe_reports)
		if invalid_index != -1:
			print("line: " + str(n) +" invalid index: " + str(invalid_index) + " with value: " + str(parts[invalid_index]))
			parts.remove_at(invalid_index)
		print(parts)
		check_report(parts, true)
		n += 1
	print("safe reports: ",safe_reports)

func check_report(parts, count_reports):
	var direction = 0
	var invalid_index = -1
	if direction == 0:
		if parts[0] > parts[1]:
			direction = -1
		else:
			direction = 1
		for i in range(parts.size() - 1):
			if parts[i+1] > parts[i] and direction == -1:
				if invalid_index == -1:
					invalid_index = i + 1
					#print("invalid number removed: ",  parts[i])
				break
			elif parts[i+1] < parts[i] and direction == 1:
				if invalid_index == -1:
					invalid_index = i + 1
					#print("invalid number removed: ",  parts[i])
				break
			elif parts[i+1] == parts[i]:
				if invalid_index == -1:
					invalid_index = i + 1
					#print("invalid number removed: ",  parts[i])
				break
			if abs(parts[i] - parts[i+1]) > 3:
				if invalid_index == -1:
					invalid_index = i + 1
					#print("invalid number removed: ",  parts[i])
				break
			if i + 2 == parts.size() and count_reports:
				safe_reports += 1
				#print("safe report")
				break
	return invalid_index
