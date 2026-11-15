extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProgressKeeper.trigger_reset.connect(on_progress)


func on_progress(progress:int):
	if progress == 3:
		queue_free()
