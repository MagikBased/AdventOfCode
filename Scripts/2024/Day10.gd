extends Node

var silver = 0
var gold = 0
var rows
var cols
var input_grid = []
var directions = [
	Vector2(0, 1),
	Vector2(0, -1),
	Vector2(-1, 0),
	Vector2(1, 0),
]

func _ready() -> void:
	for line in Main.lines:
		var row = []
		for chr in line.strip_edges():
			row.append(chr.to_int())
		input_grid.append(row)
	rows = input_grid.size()
	cols = input_grid[0].size()
	
	var trailheads = []
	for r in range(rows):
		for c in range(cols):
			if input_grid[r][c] == 0:
				trailheads.append(Vector2(c, r))
	
	var total_score = 0
	for trailhead in trailheads:
		var visited = {} 
		var score = depth_first_search(trailhead, visited)
		total_score += score

	silver = total_score
	print("Part One: ", silver)
	print("Part Two: ", gold)

func depth_first_search(position: Vector2, visited: Dictionary) -> int:
	if not is_in_bounds(position.x, position.y) or position in visited:
		return 0
	visited[position] = true
	var current_value = get_cell(position)
	if current_value == 9:
		return 1
	var total_score = 0
	for direction in directions:
		var neighbor = position + direction
		if is_in_bounds(neighbor.x, neighbor.y) and get_cell(neighbor) == current_value + 1:
			total_score += depth_first_search(neighbor, visited)
	return total_score

func is_in_bounds(x, y) -> bool:
	return 0 <= x and x < cols and 0 <= y and y < rows

func get_cell(position: Vector2) -> int:
	if is_in_bounds(position.x, position.y):
		return input_grid[int(position.y)][int(position.x)]
	return -1

func print_grid():
	for row in input_grid:
		print("".join(row))
