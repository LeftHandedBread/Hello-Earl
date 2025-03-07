extends VBoxContainer

@onready var Ani := $"../../../AnimationPlayer"

const START = preload("res://scenes/Level 1/Level 1.tscn")

#play button
func _on_button_pressed() -> void:
	AudioEngine.play_music(2)
	Ani.play("fadetoblack")
	await Ani.animation_finished
	get_tree().change_scene_to_packed(START)


func _on_button_3_pressed() -> void:
	get_tree().quit()
