extends ColorRect
class_name QuestsPopup

signal on_close()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_quests()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_button_pressed() -> void:
	on_close.emit()

func load_quests() -> void:
	#for now just some forced levels
	pass
