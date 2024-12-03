extends Node

var left_list = []
var right_list = []
var difference_sum = 0
var similarity_score = 0

func _ready():
	for line in Main.lines:
		var parts = line.strip_edges().split("   ")
		left_list.append(parts[0].to_int())
		right_list.append(parts[1].to_int())
	left_list.sort()
	right_list.sort()
	for n in left_list.size():
		difference_sum += abs(left_list[n] - right_list[n])
		similarity_score += left_list[n] * right_list.count(left_list[n])
	print("Part One: ",difference_sum)
	print("Part Two: ",similarity_score)
	
