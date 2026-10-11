extends HBoxContainer

@onready var team1 = $LabelTeam1
@onready var team2 = $LabelTeam2

func _on_control_write(counter: Counter) -> void:
	team1.text = counter.name_team_1
	team2.text = counter.name_team_2
