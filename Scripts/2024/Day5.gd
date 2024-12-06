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
			while not is_valid_update(update_pages, rules):
				fix_update_order(update_pages, rules)
			fixed_updates.append(update_pages)

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
	var page_indexes = {}
	for k in range(update_pages.size()):
		page_indexes[update_pages[k]] = k
	for page in update_pages:
		if rules.has(page):
			for after_page in rules[page]:
				if update_pages.has(after_page) and page_indexes[after_page] < page_indexes[page]:
					return false
	return true

func fix_update_order(update_pages: Array, rules: Dictionary) -> void:
	for i in range(update_pages.size() - 1):
		var page_a = update_pages[i]
		var page_b = update_pages[i + 1]
		if page_a not in rules or page_b not in rules[page_a]:
			var temp = update_pages[i]
			update_pages.remove_at(i)
			update_pages.append(temp)
			break

func get_middle_index_value(update_pages: Array) -> int:
	return update_pages[int(update_pages.size() / 2)]
