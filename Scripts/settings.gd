extends Control

@onready var name_team_1 = $VBoxContainer/NameEditTeam1
@onready var name_team_2 = $VBoxContainer/NameEditTeam2
@onready var target_points = $VBoxContainer/TargetPointsContainer/TargetPoints
@onready var graph_box = $VBoxContainer/HBoxContainer/CheckBox

func _ready() -> void:
	target_points.text = str(Globals.counter.points_target)
	graph_box.button_pressed = Globals.counter.print_graph

func _on_new_game_button_pressed() -> void:
	Globals.counter.points_team_1 = []
	Globals.counter.points_team_2 = []
	_on_return_button_pressed()


func _on_return_button_pressed() -> void:
	if !name_team_1.text.is_empty():
		Globals.counter.name_team_1 = name_team_1.text
	if !name_team_2.text.is_empty():
		Globals.counter.name_team_2 = name_team_2.text
	
	if !target_points.text.is_empty():
		Globals.counter.points_target = int(target_points.text)
	
	Globals.counter.print_graph = graph_box.button_pressed
	ResourceSaver.save(Globals.counter, Globals.SAVE_PATH)
	
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
