extends Node2D

@export var camera1:Node2D
@export var camera2:Node2D

var area:Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area = get_child(0)
	area.area_entered.connect(_area_enter)
	area.area_exited.connect(_area_leave)

func _area_leave(other_area:Area2D):
	if other_area.global_position.x > global_position.x:
		camera1.visible = false
		camera2.visible = true
	else:
		camera1.visible = true
		camera2.visible = false

func _area_enter(_other_area:Area2D):
	#print("area enter")
	pass
