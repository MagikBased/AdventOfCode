extends Node

var silver: int = 0
var gold: int = 0

var input_grid: Array = []
var neighbor_counts: Array = []
var rows: int
var cols: int
var directions := [
	Vector2i(-1, 1),
	Vector2i(0, 1),
	Vector2i(1, 1),
	Vector2i(-1, 0),
	Vector2i(1, 0),
	Vector2i(-1, -1),
	Vector2i(0, -1),
	Vector2i(1, -1),
]

func _ready() -> void:
	for line in Main.lines:
		var row: Array = []
		for chr in line.strip_edges():
			row.append(chr)
		input_grid.append(row)

	rows = input_grid.size()
	cols = input_grid[0].size()

	compute_neighbor_counts()
	process_removals()

	print("Part One: ", silver)
	print("Part Two: ", gold)

func compute_neighbor_counts() -> void:
	neighbor_counts.clear()
	neighbor_counts.resize(rows)

	for y in range(rows):
		var row_counts: Array = []
		row_counts.resize(cols)
		for x in range(cols):
			var cell = input_grid[y][x]
			var count := 0
			if cell != ".":
				for dir in directions:
					var nx = x + dir.x
					var ny = y + dir.y
					if nx < 0 or nx >= cols or ny < 0 or ny >= rows:
						continue
					if input_grid[ny][nx] == "@":
						count += 1
			row_counts[x] = count
		neighbor_counts[y] = row_counts

func process_removals() -> void:
	var queue: Array = []
	var in_queue := {}
	var initial_removed := 0

	for y in range(rows):
		var row = input_grid[y]
		var counts_row = neighbor_counts[y]
		for x in range(cols):
			var cell = row[x]
			if cell == ".":
				continue
			if counts_row[x] < 4:
				var pos := Vector2i(x, y)
				queue.append(pos)
				in_queue[pos] = true
				initial_removed += 1
	silver = initial_removed

	while queue.size() > 0:
		var pos = queue.pop_back() as Vector2i
		var x = pos.x
		var y = pos.y
		if input_grid[y][x] == ".":
			continue
		var was_at = input_grid[y][x] == "@"
		input_grid[y][x] = "."
		gold += 1
		if not was_at:
			continue
		for dir in directions:
			var nx = x + dir.x
			var ny = y + dir.y
			if nx < 0 or nx >= cols or ny < 0 or ny >= rows:
				continue
			if input_grid[ny][nx] == ".":
				continue
			neighbor_counts[ny][nx] -= 1
			if neighbor_counts[ny][nx] < 4:
				var npos := Vector2i(nx, ny)
				if not in_queue.has(npos):
					queue.append(npos)
					in_queue[npos] = true

func is_in_bounds(x: int, y: int) -> bool:
	return x >= 0 and x < cols and y >= 0 and y < rows

func get_cell(position: Vector2i):
	if is_in_bounds(position.x, position.y):
		return input_grid[position.y][position.x]
	return ""

func print_grid():
	for row in input_grid:
		var row_data := ""
		for c in row:
			row_data += str(c)
		print(row_data)
