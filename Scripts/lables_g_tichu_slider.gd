extends HBoxContainer

@onready var GTichuLabel1 = $GTichuLabel1
@onready var GTichuLabel2 = $GTichuLabel2

func _on_g_tichu_slider_1_value_changed(value: int) -> void:
	GTichuLabel1.text = switchTichu(value)

func _on_g_tichu_slider_2_value_changed(value: int) -> void:
	GTichuLabel2.text = switchTichu(value)

func switchTichu(value) -> String:
	match value:
		0:
			return "- GTichu"
		2: 
			return "+ GTichu"
		_:
			return ""
