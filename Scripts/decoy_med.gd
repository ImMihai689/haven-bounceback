extends AnimatedSprite2D

var area:Area2D
var player:AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area = get_child(0)
	player = get_child(1)
	play("default")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		for er in area.get_overlapping_areas():
			if er.is_in_group("player"):
				visible = false;
				player.play(0.3)
