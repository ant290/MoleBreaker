extends Node

signal use_crt_changed(value: bool)

var useCrtShader : bool = true
var volumeEffects : float = 1
var volumeMaster : float = 1
var volumeMusic : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_save_data() -> Dictionary:
	var save_data = {
		GameConstants.SAVE_DATA_SETTINGS_USE_CRT_SHADER : useCrtShader,
		GameConstants.SAVE_DATA_SETTINGS_VOLUME_EFFECTS : volumeEffects,
		GameConstants.SAVE_DATA_SETTINGS_VOLUME_MASTER : volumeMaster,
		GameConstants.SAVE_DATA_SETTINGS_VOLUME_MUSIC : volumeMusic
	}

	return save_data

func load_data(data: Dictionary) -> void:
	useCrtShader = data.get(GameConstants.SAVE_DATA_SETTINGS_USE_CRT_SHADER, true)
	volumeEffects = data.get(GameConstants.SAVE_DATA_SETTINGS_VOLUME_EFFECTS, 1)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(GameConstants.AUDIO_BUS_NAME_EFFECTS),volumeEffects)
	volumeMaster = data.get(GameConstants.SAVE_DATA_SETTINGS_VOLUME_MASTER, 1)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(GameConstants.AUDIO_BUS_NAME_MASTER),volumeMaster)
	volumeMusic = data.get(GameConstants.SAVE_DATA_SETTINGS_VOLUME_MUSIC, 1)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(GameConstants.AUDIO_BUS_NAME_MUSIC),volumeMusic)

func set_use_crt(value: bool) -> void:
	useCrtShader = value
	use_crt_changed.emit(useCrtShader)

func set_master_volume(value: float) -> void:
	volumeMaster = value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(GameConstants.AUDIO_BUS_NAME_MASTER),volumeMaster)

func set_music_volume(value: float) -> void:
	volumeMusic = value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(GameConstants.AUDIO_BUS_NAME_MUSIC),volumeMusic)

func set_effects_volume(value: float) -> void:
	volumeEffects = value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(GameConstants.AUDIO_BUS_NAME_EFFECTS),volumeEffects)
