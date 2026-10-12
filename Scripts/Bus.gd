extends Resource

class_name Counter

@export var points_team_1 : Array[int]
@export var points_team_2 : Array[int]

@export var name_team_1 : String
@export var name_team_2 : String

@export var points_target : int = 1000
@export var print_graph : bool = true

func change_points(team1 : int, team2 : int):
	
	points_team_1.append(team1)
	points_team_2.append(team2)

func restore():
	print(points_team_1, points_team_2)
	if points_team_1.is_empty() || points_team_2.is_empty():
		return
	
	points_team_1.remove_at(-1)
	points_team_2.remove_at(-1)
