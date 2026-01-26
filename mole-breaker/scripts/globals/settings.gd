extends Node

signal use_crt_changed(value: bool)

var useCrtShader : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_save_data() -> Dictionary:
	var save_data = {
		GameConstants.SAVE_DATA_SETTINGS_USE_CRT_SHADER : useCrtShader
	}

	return save_data

func load_data(data: Dictionary) -> void:
	useCrtShader = data[GameConstants.SAVE_DATA_SETTINGS_USE_CRT_SHADER]

func set_use_crt(value: bool) -> void:
	useCrtShader = value
	use_crt_changed.emit(useCrtShader)
