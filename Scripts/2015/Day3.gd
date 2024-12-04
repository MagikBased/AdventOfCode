extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	var current_position = Vector2(0,0)
	var santa_position = Vector2(0,0)
	var robo_position = Vector2(0,0)
	var visited_positions_silver = {}
	var visited_positions_gold = {}
	visited_positions_silver[current_position] = true
	visited_positions_gold[santa_position] = true
	for line in Main.lines:
		var i = 0
		for chr in line.strip_edges():
			match chr:
				"^": 
					current_position += Vector2(0,-1)
					if i % 2 == 0:
						santa_position += Vector2(0,-1)
					else:
						robo_position += Vector2(0,-1)
				"v": 
					current_position += Vector2(0,1)
					if i % 2 == 0:
						santa_position += Vector2(0,1)
					else:
						robo_position += Vector2(0,1)
				">": 
					current_position += Vector2(1,0)
					if i % 2 == 0:
						santa_position += Vector2(1,0)
					else:
						robo_position += Vector2(1,0)
				"<": 
					current_position += Vector2(-1,0)
					if i % 2 == 0:
						santa_position += Vector2(-1,0)
					else:
						robo_position += Vector2(-1,0)
			visited_positions_silver[current_position] = true
			visited_positions_gold[santa_position] = true
			visited_positions_gold[robo_position] = true
			i += 1
	silver = visited_positions_silver.size()
	gold = visited_positions_gold.size()
	print("Part One: ",silver)
	print("Part Two: ",gold)
