extends HBoxContainer

@onready var team1 = $SliderTeam1
@onready var team2 = $SliderTeam2

func _on_point_value_changed(value: float) -> void:
	match int(value):
		-30:
			team2.text = str(200)
			
		130:
			team1.text = str(200)
		_:
			team2.text = str(100 - value)
			team1.text = str(value)
