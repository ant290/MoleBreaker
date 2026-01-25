extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	SceneTransitions.fade_out("Breaker")
	await SceneTransitions.fade_complete
	
	get_tree().change_scene_to_file("res://scenes/brickBreaker/level.tscn")


func _on_town_button_pressed() -> void:
	SceneTransitions.fade_out("Town")
	await SceneTransitions.fade_complete
	
	get_tree().change_scene_to_file("res://scenes/town/town.tscn")
