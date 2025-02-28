extends Interactible3D

@onready var door_animation := get_node("AnimationPlayer")

@export var door_open := false

func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		if door_open:
			door_animation.play_backwards("Open Door")
		else:
			door_animation.play("Open Door")
		door_open = !door_open
