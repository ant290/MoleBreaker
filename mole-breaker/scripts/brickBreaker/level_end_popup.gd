extends ColorRect
class_name LevelEndPopup

signal on_close()

@onready var progress_bar: ProgressBar = $UiPopup/Panel/ProgressBar

var initial_xp : int = 0
var gained_xp : int = 100
var initial_level : int = 1
var final_level : int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func animate_xp_gain() -> void:
	var currentXp = initial_xp
	var endXP = initial_xp + gained_xp
	
	progress_bar.min_value = currentXp
	progress_bar.max_value = endXP
	
	var tween = get_tree().create_tween()
	tween.tween_property(progress_bar, "value", endXP, 4)

func _on_close_button_pressed() -> void:
	on_close.emit()
