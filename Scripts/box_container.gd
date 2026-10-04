extends VBoxContainer

func _ready() -> void:
	get_viewport().size_changed.connect(resize_view)
	resize_view()

func resize_view() -> void:
	var view := get_viewport_rect().size

	size = view * (10.0 / 12.0)
	position = view * (1.0 / 12.0)
