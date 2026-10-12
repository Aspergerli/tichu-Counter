extends HBoxContainer

@onready var TichuLabel1 = $TichuLabel1
@onready var TichuLabel2 = $TichuLabel2

func _on_tichu_slider_1_value_changed(value: int) -> void:
	TichuLabel1.text = switchTichu(value)


func _on_tichu_slider_2_value_changed(value: int) -> void:
	TichuLabel2.text = switchTichu(value)

func switchTichu(value) -> String:
	match value:
		0:
			return "- Tichu"
		2: 
			return "+ Tichu"
		_:
			return ""
