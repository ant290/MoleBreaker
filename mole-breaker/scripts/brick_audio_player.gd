extends AudioStreamPlayer

var brickBreak : AudioStream = preload("res://assets/sounds/effects/Dripish A.wav")
var brickCrack : AudioStream = preload("res://assets/sounds/effects/Cartoon Pop.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_break() -> void:
	stream = brickBreak
	play()
	
func play_crack() -> void:
	stream = brickCrack
	play()
