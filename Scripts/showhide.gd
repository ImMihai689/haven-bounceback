extends Node2D

@export var show_hide:bool = false
@export var progress:int = 0

func _ready() -> void:
	ProgressKeeper.trigger_reset.connect(showhide)

func showhide(_progress:int):
	if _progress >= progress:
		visible = show_hide

func force_showhide(vis:bool):
	visible = vis
