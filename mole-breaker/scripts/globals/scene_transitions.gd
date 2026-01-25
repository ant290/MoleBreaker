extends Node
## Scene Transitions Singleton

## Signals
signal fade_complete

## Node References
@onready var fade_to_black: ColorRect = $CanvasLayer/FadeToBlack
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $CanvasLayer/Label

## Variables

## Initialization
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_to_black.hide()
	label.hide()

func fade_in() -> void:
	fade_to_black.show()
	animation_player.play("scene_transition")
	
	await animation_player.animation_finished
	
	label.hide()
	fade_to_black.hide()
	
func fade_out(labelText: String = "") -> void:
	fade_to_black.show()
	animation_player.play_backwards("scene_transition")

	await animation_player.animation_finished
	fade_to_black.hide()
	
	if labelText.length() > 0:
		set_label(labelText)
	
	fade_complete.emit()
	
func set_label(labelText: String) -> void:
	label.text = labelText
	label.show()

func fade_in_with_title(title: String) -> void:
	set_label(title)
	label.show()
	fade_in()
