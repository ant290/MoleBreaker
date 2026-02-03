extends AudioStreamPlayer
class_name AmbientMusicPlayer

const MUSIC_NAME_CABIN : String = "cabin"
const MUSIC_NAME_GARDEN : String = "garden"

var music_cabin : AudioStream = preload("res://assets/sounds/music/Fantasy Vol5 Cabin Lunch Intensity 1.wav")
var music_garden : AudioStream = preload("res://assets/sounds/music/Fantasy Vol5 Lush Gardens Intensity 1.wav")

var current_music_name : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func play_ambient_music(musicName: String) -> void:
	if current_music_name == musicName and playing:
		return
		
	match musicName:
		MUSIC_NAME_CABIN:
			stream = music_cabin
		MUSIC_NAME_GARDEN:
			stream = music_garden
			
	current_music_name = musicName
	play()


func _on_finished() -> void:
	play()
