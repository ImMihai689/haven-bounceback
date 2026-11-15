extends Control

@export var difficulty_settings:Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if visible:
			visible = false
		else:
			difficulty_settings.visible = false
			visible = true

func _on_resume_button_up() -> void:
	visible = false


func _on_options_button_up() -> void:
	difficulty_settings.visible = !difficulty_settings.visible
	pass


func _on_quit_button_up() -> void:
	get_tree().quit()
