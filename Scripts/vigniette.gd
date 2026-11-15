extends ColorRect

@export var text:Label
@export var initial_filter:Color
@export var filter:ColorRect

var last_progress:int = 0

var ready_to_reset = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProgressKeeper.trigger_progress.connect(increase_vigniette)
	ProgressKeeper.trigger_reset.connect(change_filter)
	ProgressKeeper.trigger_reset.connect(decrease_vigniette)

func increase_vigniette():
	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/alpha", 4.0, 2.5)
	tween.chain().tween_property(material, "shader_parameter/dark", 1.0, 1)
	if ProgressKeeper.progress != last_progress:
		tween.chain().tween_property(text, "visible_ratio", 1.0, 1.5).finished.connect(reset)
	else:
		tween.chain().tween_property(text, "visible_ratio", 0.0, 0).finished.connect(reset)
	last_progress = ProgressKeeper.progress

func reset():
	ready_to_reset = true

func _input(event: InputEvent) -> void:
	if ready_to_reset and event.is_action_pressed("respawn"):
		ready_to_reset = false;
		ProgressKeeper.trigger_reset.emit(ProgressKeeper.progress)

func change_filter(progress:int):
	filter.color = lerp(initial_filter, Color.WHITE, float(progress) / 3)

func decrease_vigniette(_progress:int):
	var tween = create_tween()
	tween.tween_property(text, "visible_ratio", 0.0, 0)
	tween.chain().tween_property(material, "shader_parameter/dark", 0.0, 0)
	tween.chain().tween_property(material, "shader_parameter/alpha", 1.0, 1)
	
