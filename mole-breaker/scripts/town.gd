extends Node2D

@onready var crtShader : CanvasLayer = $CRTShader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crtShader.visible = Settings.useCrtShader
	SceneTransitions.fade_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_touch_screen_button_released() -> void:
	SceneTransitions.fade_out()
	await SceneTransitions.fade_complete
	
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
