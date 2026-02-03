extends Node
class_name SaveService

func save_game() -> void:
	var save_data = {}
	save_data[GameConstants.SAVE_DATA_PLAYER_STATS] = PlayerStats.get_save_data()
	save_data[GameConstants.SAVE_DATA_SETTINGS] = Settings.get_save_data()

	var save_file = FileAccess.open(GameConstants.SAVE_DATA_FILE_NAME, FileAccess.WRITE)
	
	var json = JSON.stringify(save_data)
	
	save_file.store_line(json)
	
func load_game() -> void:
	if not FileAccess.file_exists(GameConstants.SAVE_DATA_FILE_NAME):
		return # Error, no file found
	
	var save_file = FileAccess.open(GameConstants.SAVE_DATA_FILE_NAME, FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		var json_helper = JSON.new()
		
		var parse_result = json_helper.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json_helper.get_error_message(), " in ", json_string, " at line ", json_helper.get_error_line())
			continue
		
		var data = json_helper.data
		
		for key in data.keys():
			#match the key to a const and load that data to each class
			match key:
				GameConstants.SAVE_DATA_PLAYER_STATS:
					PlayerStats.load_data(data[key])
				GameConstants.SAVE_DATA_SETTINGS:
					Settings.load_data(data[key])
				_:
					print("UNKNOWN save data component", key)
