extends Control

const SAVE_PATH = "user://points.tres"

var bus : Counter = null

@onready var pointSlider = $VBoxContainer/SliderContainer/PointSlider
# Fetch Paths to the Four Tichu Sliders
@onready var tichuSlider1 = $VBoxContainer/TichuContainer/TichuSlider1
@onready var tichuSlider2 = $VBoxContainer/TichuContainer/TichuSlider2
@onready var grossesTichuSlider1 = $VBoxContainer/TichuContainer/GTichuSlider1
@onready var grossesTichuSlider2 = $VBoxContainer/TichuContainer/GTichuSlider2

signal write(pointsTeam1, pointsTeam2)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		bus = ResourceLoader.load(SAVE_PATH)
		
	else:
		bus = Counter.new()

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
	var team_1 : int = bus.points_team_1
	var team_2 : int = bus.points_team_2
	
	match int(pointSlider.value):
		-30:
			team_1 += 200
			
		130:
			team_2 += 200
		_:
			team_2 += 100 - pointSlider.value
			team_1 += pointSlider.value
	
	team_1 += switchTichu(tichuSlider1.value) + switchTichu(grossesTichuSlider1.value)*2
	team_2 += switchTichu(tichuSlider2.value) + switchTichu(grossesTichuSlider2.value)*2
	bus.change_points(team_1, team_2)
	
	ResourceSaver.save(bus, SAVE_PATH)
	write.emit(bus.points_team_1, bus.points_team_2)
	
	reset_ui()


func _on_undo_button_pressed() -> void:
	bus.restore()
	write.emit(bus.points_team_1, bus.points_team_2)
	reset_ui()

func reset_ui() -> void:
	pointSlider.value = 50
	tichuSlider1.value = 1
	tichuSlider2.value = 1 
	grossesTichuSlider1.value = 1
	grossesTichuSlider2.value = 1
