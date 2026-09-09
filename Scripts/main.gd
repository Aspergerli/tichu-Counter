extends Control

var bus : Counter = null

const SAVE_PATH = "user://saves/points.tres"

@onready var pointSlider = $VBoxContainer/HBoxContainer/PointSlider
# Fetch Paths to the Four Tichu Sliders
@onready var tichuSlider1 = $VBoxContainer/GridContainer/TichuSlider1
@onready var tichuSlider2 = $VBoxContainer/GridContainer/TichuSlider2
@onready var grossesTichuSlider1 = $VBoxContainer/GridContainer/GTichuSlider1
@onready var grossesTichuSlider2 = $VBoxContainer/GridContainer/GTichuSlider2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if( !DirAccess.dir_exists_absolute( SAVE_PATH ) ):
		var _e1:Error = DirAccess.make_dir_absolute(SAVE_PATH);
	if ResourceLoader.exists(SAVE_PATH):
		bus = ResourceLoader.load(SAVE_PATH)
	else:
		bus = Counter.new()


#func _on_point_slider_drag_ended(value_changed: bool) -> void:
	#points_team_1 += pointSlider.value
	#points_team_2 += 100 - pointSlider.value
	#print(points_team_1," ", points_team_2)

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
	match int(pointSlider.value):
		-30:
			bus.points_team_1 += 200
			
		130:
			bus.points_team_2 += 200
		_:
			bus.points_team_1 += 100 - pointSlider.value
			bus.points_team_2 += pointSlider.value
	
	bus.points_team_1 += switchTichu(tichuSlider1.value) + switchTichu(grossesTichuSlider1.value)*2
	bus.points_team_2 += switchTichu(tichuSlider2.value) + switchTichu(grossesTichuSlider2.value)*2
	ResourceSaver.save(bus, SAVE_PATH)
	print(bus.points_team_1, " ", bus.points_team_2)
