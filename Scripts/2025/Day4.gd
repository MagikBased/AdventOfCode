extends Node

var silver = 0
var gold = 0
var input_grid = []
var rows
var cols
var directions = [
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
		var row = []
		for chr in line.strip_edges():
			row.append(chr)
		input_grid.append(row)
	rows = input_grid.size()
	cols = input_grid[0].size()
	
	var removed_count := remove_paper_rolls()
	silver = removed_count
	
	while removed_count > 0:
		removed_count = remove_paper_rolls()

	print("Part One: ", silver)
	print("Part Two: ", gold)

func remove_paper_rolls() -> int:
	var removed_count = 0
	var remove_locations := []
	for y in range(0,rows):
		for x in range(0, cols):
			var paper_neighbors := 0
			if get_cell(Vector2i(x,y)) == ".":
				continue
			for dir in directions:
				var cell: Vector2i = Vector2i(x, y) + dir
				if get_cell(cell) == "@":
					paper_neighbors += 1
					if paper_neighbors > 3:
						break
			if paper_neighbors < 4:
				removed_count += 1
				remove_locations.append(Vector2i(x,y))
	gold += remove_locations.size()
	for loc in remove_locations:
		input_grid[loc.y][loc.x] = "."
	return removed_count

func is_in_bounds(x, y) -> bool:
	return 0 <= x and x < cols and 0 <= y and y < rows

func get_cell(position: Vector2i):
	if is_in_bounds(position.x, position.y):
		return input_grid[int(position.y)][int(position.x)]
	return ""

func print_grid():
	for row in input_grid:
		var row_data = ""
		for c in row:
			row_data += str(c)
		print(row_data)
