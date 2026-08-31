extends BoxContainer

@onready var punkte1 = $Punkte1
@onready var punkte2 = $Punkte2

var team1_punkte := 5
var team2_punkte := 20

func _ready() -> void:
	punkte1.text = str(team1_punkte)
	punkte2.text = str(team2_punkte)

func update_punkte():
	punkte1.text = str(team1_punkte)
	punkte2.text = str(team2_punkte)
