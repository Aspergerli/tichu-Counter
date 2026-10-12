extends Node

const SAVE_PATH = "user://points.tres"

var counter : Counter = null

func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		counter = ResourceLoader.load(SAVE_PATH)
		
	else:
		counter = Counter.new()
