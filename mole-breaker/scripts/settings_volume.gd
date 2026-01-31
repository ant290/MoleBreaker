extends HSplitContainer
class_name SettingsVolume

@export var title : String = "title"

@onready var _label = $Label
@onready var _slider = $HSlider

signal volume_drag_ended(value: float)
signal volume_drag_changed(value: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_label.text = title

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_slider_value(value: float) -> void:
	_slider.set_value_no_signal(value)

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		volume_drag_ended.emit(_slider.value)


func _on_h_slider_value_changed(value: float) -> void:
	volume_drag_changed.emit(value)
