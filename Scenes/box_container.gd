extends BoxContainer


# Called when the node enters the scene tree for the first time.
# Sets the correct size for the ui
func _ready() -> void:
	var view = get_viewport().size
	size.x = view.x / 12 * 10
	size.y = view.y / 12 * 10
	position.x = view.x / 12
	position.y = view.y / 12
