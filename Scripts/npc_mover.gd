extends Node

class_name NPCMover

@export var moving_speed:float = 380

@export var animated_sprite:AnimatedSprite2D

var current_speed:float = 0

var parent:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not get_parent() is Node2D:
		printerr("Parent of npc_mover has to inherit Node2D!")
	parent = get_parent()

func _physics_process(delta: float) -> void:
	parent.move_and_collide(Vector2(1, 0) * current_speed * moving_speed * delta)

func move_npc(speed:float) -> void:
	var next_animation = ""
	if speed > 0:
		next_animation = "move right"
	elif speed < 0:
		next_animation = "move left"
	else:
		if current_speed > 0:
			next_animation = "stand right"
		elif current_speed < 0:
			next_animation = "stand left"
	
	current_speed = speed
	
	if animated_sprite:
		animated_sprite.scale = Vector2(1, 1)
		if next_animation == "move right":
			animated_sprite.play("walk")
			animated_sprite.flip_h = false
		elif next_animation == "move left":
			animated_sprite.play("walk")
			animated_sprite.flip_h = true
		elif next_animation == "stand right":
			animated_sprite.play("stand")
			animated_sprite.flip_h = false
		elif next_animation == "stand left":
			animated_sprite.play("stand")
			animated_sprite.flip_h = true

func explosion_done():
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if not parent.dead:
		if event.is_action_pressed("ui_accept"):
			animated_sprite.scale = Vector2(4, 4)
			animated_sprite.play("bum")
			parent.dead = true
			animated_sprite.animation_finished.connect(explosion_done)
