extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	var input_sections = parse_input()
	var rules = parse_rules(input_sections[0])
	var fixed_updates = []
	for update in input_sections[1]:
		var update_pages = parse_update(update)
		if is_valid_update(update_pages, rules):
			silver += get_middle_index_value(update_pages)
		else:
			var fixed_order = topological_sort(update_pages, rules)
			if fixed_order:
				fixed_updates.append(fixed_order)
	for fixed_update in fixed_updates:
		gold += get_middle_index_value(fixed_update)

	print("Part One: ", silver)
	print("Part Two: ", gold)

func parse_input() -> Array:
	var input_sections = [[]]
	for line in Main.lines:
		if line.is_empty():
			input_sections.append([])
		else:
			input_sections[-1].append(line.strip_edges())
	return input_sections

func parse_rules(section_one: Array) -> Dictionary:
	var rules = {}
	for rule in section_one:
		var pages = rule.split("|")
		var before = pages[0].to_int()
		var after = pages[1].to_int()
		if not rules.has(before):
			rules[before] = []
		rules[before].append(after)
	return rules

func parse_update(update: String) -> Array:
	var update_pages = update.split(",") as Array
	for i in range(update_pages.size()):
		update_pages[i] = update_pages[i].to_int()
	return update_pages

func is_valid_update(update_pages: Array, rules: Dictionary) -> bool:
	var sorted_order = topological_sort(update_pages, rules)
	return sorted_order == update_pages

func topological_sort(update_pages: Array, rules: Dictionary) -> Array:
	var graph = {}
	var in_degree = {}
	for page in update_pages:
		if not graph.has(page):
			graph[page] = []
		if not in_degree.has(page):
			in_degree[page] = 0
	for page in update_pages:
		if rules.has(page):
			for neighbor in rules[page]:
				if neighbor in update_pages:
					graph[page].append(neighbor)
					in_degree[neighbor] += 1
	var queue = []
	for page in update_pages:
		if in_degree[page] == 0:
			queue.append(page)
	var sorted_order = []
	while not queue.is_empty():
		var current = queue.pop_front()
		sorted_order.append(current)
		for neighbor in graph[current]:
			in_degree[neighbor] -= 1
			if in_degree[neighbor] == 0:
				queue.append(neighbor)
	return sorted_order if sorted_order.size() == update_pages.size() else Array()

func get_middle_index_value(update_pages: Array) -> int:
	return update_pages[int(update_pages.size() / 2)]
