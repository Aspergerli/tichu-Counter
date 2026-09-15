extends HBoxContainer

@onready var team1 = $PointsTeam1
@onready var team2 = $PointsTeam2

func _on_write(pointsTeam1: Variant, pointsTeam2: Variant) -> void:
	team1.text = str(pointsTeam1)
	team2.text = str(pointsTeam2)
