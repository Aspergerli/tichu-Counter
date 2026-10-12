extends Control

@onready var pointSlider = $VBoxContainer/SliderContainer/PointSlider
# Fetch Paths to the Four Tichu Sliders
@onready var tichuSlider1 = $VBoxContainer/TichuContainer/TichuSlider1
@onready var tichuSlider2 = $VBoxContainer/TichuContainer/TichuSlider2
@onready var grossesTichuSlider1 = $VBoxContainer/TichuContainer/GTichuSlider1
@onready var grossesTichuSlider2 = $VBoxContainer/TichuContainer/GTichuSlider2

signal write(counter: Counter)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	write.emit(Globals.counter)

# Used to get the correct value to write to the score when a Tichu / GT is called
func switchTichu(value: int):
	match value:
		0:
			return -100
		2:
			return 100
		_:
			return 0

func _on_save_pressed() -> void:
	var team_1 : int
	var team_2 : int
	
	if Globals.counter.points_team_1.is_empty() || Globals.counter.points_team_2.is_empty():
		team_1 = 0
		team_2 = 0
	else:
		team_1 = Globals.counter.points_team_1.back()
		team_2 = Globals.counter.points_team_2.back()
	
	match int(pointSlider.value):
		-30:
			team_2 += 200
			
		130:
			team_1 += 200
		_:
			team_2 += 100 - pointSlider.value
			team_1 += pointSlider.value
	
	team_1 += switchTichu(tichuSlider1.value) + switchTichu(grossesTichuSlider1.value)*2
	team_2 += switchTichu(tichuSlider2.value) + switchTichu(grossesTichuSlider2.value)*2
	Globals.counter.change_points(team_1, team_2)
	ResourceSaver.save(Globals.counter, Globals.SAVE_PATH)
	
	if team_1 >= Globals.counter.points_target || team_2 >= Globals.counter.points_target:
		get_tree().change_scene_to_file("res://Scenes/graph.tscn")
		return
	
	write.emit(Globals.counter)
	
	reset_ui()


func _on_undo_button_pressed() -> void:
	Globals.counter.restore()
	write.emit(Globals.counter)
	reset_ui()

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")

func reset_ui() -> void:
	pointSlider.value = 50
	tichuSlider1.value = 1
	tichuSlider2.value = 1 
	grossesTichuSlider1.value = 1
	grossesTichuSlider2.value = 1
