extends Node

var progress:int

signal trigger_progress()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func collect_pill(id:int):
	progress = id
	print("colelcted pill " + str(id))
	trigger_progress.emit()
