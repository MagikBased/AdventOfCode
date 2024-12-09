extends Node2D

var input_path:String = "res://Inputs/input_day_1.txt"
var input = FileAccess.open(input_path,FileAccess.READ)
var lines:Array = []
var current_year:int = 2024
var day_functions = {}
var session_cookie:String = ""
var base_url:String = "https://adventofcode.com/2024/day/"
var http_request: HTTPRequest

func _ready() -> void:
	load_day_functions(current_year)
	session_cookie = get_session_cookie()
	setup_http_request()
	#fetch_input_for_day(3)

func load_day_functions(year):
	var year_path = "res://Scripts/" + str(year) + "/"
	for day in range(1,26):
		var script_path = year_path + "Day" + str(day) + ".gd"
		if FileAccess.file_exists(script_path):
			day_functions[day] = load(script_path).new()

func execute_day(day: int):
	read_lines_from_file(day)
	if day_functions.has(day):
		var day_script = day_functions[day]
		var start_time = Time.get_ticks_msec()
		day_script._ready()
		var end_time = Time.get_ticks_msec()
		var execution_time = float(end_time - start_time)
		print("Execution Time: ", execution_time, " ms")
	else:
		print("Script for Day ", day, " not found.")

func read_lines_from_file(day):
	input_path = "res://Inputs/" + str(current_year) + "/input_day_" + str(day) + ".txt"
	if not FileAccess.file_exists(input_path):
		print("Error: File does not exist at path: ", input_path)
		lines.clear()
		return
	input = FileAccess.open(input_path, FileAccess.READ)
	if not input:
		print("Error: Unable to open file: ", input_path)
		lines.clear()
		return
	lines.clear()
	while not input.eof_reached():
		lines.append(input.get_line().strip_edges())
	input.close()
	#var non_empty_lines = []
	#for line in lines:
		#if not line.is_empty():
			#non_empty_lines.append(line)
	#lines = non_empty_lines
	if lines.size() == 0:
		print("Warning: The file is empty: ", input_path)
	elif lines[-1] == "":
		lines.pop_back()

func get_session_cookie() -> String:
	var get_cookie = OS.get_environment("AOC_SESSION_COOKIE")
	if get_cookie == "":
		print("Session cookie enviroment variable not found.")
		return ""
	return get_cookie

func setup_http_request() -> void:
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(Callable(self, "_on_http_request_completed"))

func fetch_input_for_day(day: int):
	var url = base_url + str(day) + "/input"
	print("Fetching input from: ", url)
	var headers = ["Cookie: session=" + session_cookie]
	http_request.request(url,headers)

func _on_http_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		input = body.get_string_from_utf8()
		print("Input for day fetched successfully:")
		#process_input(input)
	else:
		print("Failed to fetch input. Response code: ", response_code)

func process_input(get_input: String):
	var file_path = "user://input_day.txt"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(get_input)
	file.close()
	print("Input saved to: ", file_path)
