extends Node2D

@export var timer:Timer
@export var area1:Area2D
@export var area2:Area2D
@export var animated:AnimatedSprite2D
@export var animated2:AnimatedSprite2D
@export var speed:float = 40
@export var x_max:float
@export var x_min:float

var direction:float = 1
var out_for_player:bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProgressKeeper.trigger_reset.connect(on_progress)
	position.x = x_min


func _physics_process(delta: float) -> void:
	if out_for_player:
		for ar in area1.get_overlapping_areas():
			if ar.is_in_group("player"):
				out_for_player = false
				ProgressKeeper.collect_pill(ProgressKeeper.progress)
	if out_for_player:
		for ar in area2.get_overlapping_areas():
			if ar.is_in_group("player"):
				out_for_player = false
				ProgressKeeper.collect_pill(ProgressKeeper.progress)
	
	if direction > 0:
		position.x += direction * speed * delta
		if position.x >= x_max:
			direction = -1
	elif direction < 0:
		position.x += direction * speed * delta
		if position.x <= x_min:
			direction = 1

func on_progress(progress:int):
	timer.start(1)
	if progress == 3:
		animated.play("3")
		animated2.play("3")


func _on_timer_timeout() -> void:
	out_for_player = true
