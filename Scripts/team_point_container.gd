extends HBoxContainer

@onready var team1 = $PointsTeam1
@onready var team2 = $PointsTeam2

func _on_write(counter: Counter) -> void:
	var team_1_value: int
	var team_2_value: int
	if counter.points_team_1.is_empty() || counter.points_team_2.is_empty():
		team_1_value = 0
		team_2_value = 0
	else :
		team_1_value = counter.points_team_1.back()
		team_2_value = counter.points_team_2.back()
	team1.text = str(team_1_value)
	team2.text = str(team_2_value)
