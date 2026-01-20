extends Node
class_name SaveService

var save_data

const file_name = "user://savegame.save"

func save_game() -> void:
	var save_file = FileAccess.open(file_name, FileAccess.WRITE)
	
	var json = JSON.stringify(PlayerStats.brickInventory)
	
	save_file.store_line(json)
	
func load_game() -> void:
	if not FileAccess.file_exists(file_name):
		return # Error, no file found
	
	var save_file = FileAccess.open(file_name, FileAccess.READ)
	
	var file_position = 0
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		var json_helper = JSON.new()
		
		var parse_result = json_helper.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json_helper.get_error_message(), " in ", json_string, " at line ", json_helper.get_error_line())
			continue
		
		var data = json_helper.data
		var parsed_brickInventory: Dictionary[GameConstants.BrickType, int] = {}
		
		for i in data.keys():
			var brick_type = int(i)
			parsed_brickInventory[brick_type] = int(data[i])
		
		PlayerStats.brickInventory = parsed_brickInventory
		
		file_position += 1
