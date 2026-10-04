extends Resource

class_name Counter

@export var points_team_1 : int
@export var points_team_2 : int

@export var previous_team_1 : int
@export var previous_team_2 : int

func change_points(team1 : int, team2 : int):
	previous_team_1 = points_team_1
	previous_team_2 = points_team_2
	
	points_team_1 = team1
	points_team_2 = team2

func restore():
	var temp_team_1 = points_team_1
	var temp_team_2 = points_team_2
	
	points_team_1 = previous_team_1
	points_team_2 = previous_team_2
	
	previous_team_1 = temp_team_1
	previous_team_2 = temp_team_2
