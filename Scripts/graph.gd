extends Control

@onready var label = $VBoxContainer/Label
@onready var graph = $VBoxContainer/Graph
@onready var button = $VBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var winner : String = ""
	if Globals.counter.points_team_1.back() >= Globals.counter.points_team_2.back():
		winner = Globals.counter.name_team_1
	else:
		winner = Globals.counter.name_team_2
	
	label.text = "{0} win".format([winner])
	if Globals.counter.print_graph:
		draw_graph()
		button.size_flags_vertical = SIZE_SHRINK_END
	else :
		graph.visible = false
		button.size_flags_vertical = SIZE_EXPAND + SIZE_SHRINK_END

# Please do NOT change anything in this abomination, it works & I don't know how.
func draw_graph():
	var dataset = TauPlot.Dataset.new(
		TauPlot.Dataset.Mode.SHARED_X,
		TauPlot.Dataset.XElementType.NUMERIC
	)
	
	var team_1_series = dataset.add_series(Globals.counter.name_team_1)
	var team_2_series = dataset.add_series(Globals.counter.name_team_2)
	
	Globals.counter.points_team_1.push_front(0)
	Globals.counter.points_team_2.push_front(0)
	
	for index : int in  Globals.counter.points_team_1.size():
		var data = PackedFloat64Array()
		data.append(Globals.counter.points_team_1[index])
		data.append(Globals.counter.points_team_2[index])
		dataset.append_shared_sample(index, data)
	
	var config = TauXYConfig.new()
	var x_axis = TauAxisConfig.new()
	var y_axis = TauAxisConfig.new()
	
	var pane : TauPaneConfig = TauPaneConfig.new()
	
	pane.y_left_axis = y_axis
	
	var lineConf = TauLineConfig.new()
	
	pane.overlays.append(lineConf)
	
	lineConf.mode = TauLineConfig.LineMode.INDEPENDENT
	
	var float_array : Array[float] = [4.0]
	lineConf.style.line_widths_px = float_array
	
	var fillConf = TauLineFill.new()
	fillConf.fill_mode = TauLineFill.FillMode.TO_BASELINE
	
	lineConf.style.fills.append(fillConf)
	
	x_axis.scale = TauAxisConfig.Scale.LINEAR
	x_axis.title = "round"
	x_axis.include_zero_in_domain = true
	
	y_axis.scale = TauAxisConfig.Scale.LINEAR
	y_axis.title = "points"
	y_axis.include_zero_in_domain = true
	
	config.x_axis = x_axis
	config.panes.append(pane)
	
	
	var bindings : Array[TauXYSeriesBinding] = [TauXYSeriesBinding.new(), TauXYSeriesBinding.new()]
	
	bindings[0].series_id = team_1_series
	bindings[1].series_id = team_2_series
	
	for binding in bindings:
		binding.pane_index = 0
		binding.overlay_type = TauPlot.PaneOverlayType.LINE
	graph.plot_xy(dataset, config, bindings)
