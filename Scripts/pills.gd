extends Node2D

@export var area:Area2D
@export var pill_id:int

var done:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if not done and event.is_action_pressed("interact"):
		for ar in area.get_overlapping_areas():
			if ar.is_in_group("player"):
				ProgressKeeper.collect_pill(pill_id)
				visible = false
				done = true
