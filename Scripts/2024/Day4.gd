extends Node

var silver = 0
var gold = 0

var word = "XMAS"
var x_word = "MAS"
var input_grid = []
var rows
var columns
var directions = [
	Vector2(0, 1),
	Vector2(0, -1),
	Vector2(-1, 0),
	Vector2(1, 0),
	Vector2(-1, 1),
	Vector2(-1, -1),
	Vector2(1, 1),
	Vector2(1, -1),
]
func _ready() -> void:
	for line in Main.lines:
		var row = []
		for chr in line.strip_edges():
			row.append(chr)
		input_grid.append(row)
	rows = input_grid.size()
	columns = input_grid[0].size()
	for row in range(rows):
		for col in range(columns):
			for direction in directions:
				if search_grid(input_grid, word, row, col, direction):
					silver += 1
	for row in range(1, rows - 1):
		for col in range(1, columns - 1):
			if search_x_grid(input_grid, x_word, row, col):
				gold += 1
				#print("Found '", x_word, "' at center (", row + 1, ",", col + 1, ")")
	print("Part One: ", silver)
	print("Part Two: ", gold)


func search_grid(grid: Array, _search_word: String, row: int, col: int, direction: Vector2) -> bool:
	var word_length = word.length()
	for i in range(word_length):
		var new_row = row + int(direction.x) * i
		var new_col = col + int(direction.y) * i
		if new_row < 0 or new_row >= rows or new_col < 0 or new_col >= columns:
			return false
		if grid[new_row][new_col] != word[i]:
			return false
	return true

func search_x_grid(grid: Array, _search_word: String, center_row: int, center_col: int) -> bool:
	if grid[center_row][center_col] != _search_word[1]:
		return false
	if center_row - 1 < 0 or center_row + 1 >= rows or center_col - 1 < 0 or center_col + 1 >= columns:
		return false
	
	var diag1_forward = grid[center_row - 1][center_col - 1] == _search_word[0] and grid[center_row + 1][center_col + 1] == _search_word[2]
	var diag1_backward = grid[center_row - 1][center_col - 1] == _search_word[2] and grid[center_row + 1][center_col + 1] == _search_word[0]
	var diag2_forward = grid[center_row - 1][center_col + 1] == _search_word[0] and grid[center_row + 1][center_col - 1] == _search_word[2]
	var diag2_backward = grid[center_row - 1][center_col + 1] == _search_word[2] and grid[center_row + 1][center_col - 1] == _search_word[0]
	
	return (diag1_forward or diag1_backward) and (diag2_forward or diag2_backward)
