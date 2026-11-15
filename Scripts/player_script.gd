extends Node2D

@export var mover:NPCMover
@export var animated:AnimatedSprite2D

var dead:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProgressKeeper.trigger_progress.connect(die)

func _input(event: InputEvent) -> void:
	if not dead:
		if event.is_action_released("ui_left") or event.is_action_released("ui_right"):
			mover.move_npc(0)
		elif event.is_action_pressed("ui_right"):
			mover.move_npc(1)
		elif event.is_action_pressed("ui_left"):
			mover.move_npc(-1)

func die():
	dead = true
	mover.move_npc(0)
	animated.play("fall")
