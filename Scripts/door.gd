extends Node2D

@export var final_destination:Vector2
@export var required_sanity:int

var area:Area2D
var current_sanity:int

signal door_entered()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area = get_child(0)
	ProgressKeeper.trigger_reset.connect(get_sanity)

func get_sanity(progress:int):
	current_sanity = progress

func _input(event: InputEvent) -> void:
	if current_sanity >= required_sanity:
		if event.is_action_pressed("interact"):
			for ar in area.get_overlapping_bodies():
				if ar.is_in_group("player"):
					ar.position = final_destination
					door_entered.emit()
