extends CharacterBody2D

@export var timer:Timer
@export var player_kill:Area2D
@export var animated:AnimatedSprite2D
@export var player:Node2D
@export var player_detect:Area2D
@export var x_target:float
@export var chase_speed:float = 160
@export var return_speed:float = 65

var is_player:bool
var out_for_player:bool = true

func _ready() -> void:
	ProgressKeeper.trigger_reset.connect(on_progress)

func _physics_process(delta: float) -> void:
	if out_for_player:
		for ar in player_kill.get_overlapping_areas():
			if ar.is_in_group("player"):
				out_for_player = false
				ProgressKeeper.collect_pill(ProgressKeeper.progress)
	
	if is_player:
		if player.position.x > position.x:
			move_and_collide(Vector2(1, 0) * chase_speed * delta)
			animated.flip_h = true
		else:
			move_and_collide(Vector2(-1, 0) * chase_speed * delta)
			animated.flip_h = false
	else:
		if position.x > x_target:
			move_and_collide(Vector2(-1, 0) * return_speed * delta)
			animated.flip_h = true
		else:
			move_and_collide(Vector2(1, 0) * return_speed * delta)
			animated.flip_h = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("PLAYER")
		is_player = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("NO PLAYER")
		is_player = false

func on_progress(progress:int):
	timer.start(1)
	if progress != 0:
		animated.play(str(progress))

func reset_attack():
	out_for_player = true
