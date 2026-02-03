extends ColorRect
class_name LevelEndPopup

signal on_close()

@onready var progress_bar: ProgressBar = $UiPopup/Panel/ProgressBar
@onready var xp_gain: Label = $UiPopup/Panel/XPGain
@onready var level: Label = $UiPopup/Panel/Level

var initial_xp : int = 0
var next_max_xp : int = 90
var gained_xp : int = 100
var initial_level : int = 1
var current_xp : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_test_gain()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _test_gain() -> void:
	initial_xp = 0
	initial_level = 1
	gained_xp = 150
	animate_xp_gain()
	
func animate_xp_gain() -> void:
	_set_level_label()
	if current_xp < initial_xp:
		current_xp = initial_xp
	var endXP = initial_xp + gained_xp
	
	progress_bar.min_value = current_xp
	progress_bar.max_value = next_max_xp
	
	var tween = get_tree().create_tween()
	if endXP <= next_max_xp:
		tween.tween_property(progress_bar, "value", endXP, 4)
		tween.tween_callback(_progress_xp_animation.bind(endXP))
		
	else:
		tween.tween_property(progress_bar, "value", next_max_xp, 3)
		tween.tween_callback(_progress_xp_animation.bind(next_max_xp))

func _progress_xp_animation(animatedXpAmount : int) -> void:
	#update details
	current_xp = animatedXpAmount
	var endXP = initial_xp + gained_xp

	if current_xp == next_max_xp and current_xp > initial_xp:
		initial_level = initial_level + 1
		_set_level_label()
		next_max_xp = PlayerStats.get_next_xp_cap(next_max_xp)

	if current_xp < endXP:
		animate_xp_gain()


func _set_next_max_xp() -> void:
	next_max_xp = PlayerStats.get_next_xp_cap(next_max_xp)

func _on_close_button_pressed() -> void:
	on_close.emit()

func _on_progress_bar_value_changed(value: float) -> void:
	xp_gain.text = "XP Gained: " + str(int(value - initial_xp))

func _set_level_label() -> void:
	level.text = "Level: " + str(initial_level)
