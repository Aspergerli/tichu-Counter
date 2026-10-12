extends Button

func _on_pressed() -> void:
	Globals.counter.points_team_1 = []
	Globals.counter.points_team_2 = []
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
