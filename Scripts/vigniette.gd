extends ColorRect

@export var text:Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProgressKeeper.trigger_progress.connect(increase_vigniette)

func increase_vigniette():
	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/alpha", 4.0, 2.5)
	tween.chain().tween_property(material, "shader_parameter/dark", 1.0, 1)
	tween.chain().tween_property(text, "visible_ratio", 1.0, 1.5)
