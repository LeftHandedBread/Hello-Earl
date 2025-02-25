extends Interactible3D

@onready var door_animation := get_node("AnimationPlayer")

var isOpen := false

func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		print("Door opened")
		if isOpen:
			door_animation.play_backwards("Open Door")
		else:
			door_animation.play("Open Door")
		isOpen = !isOpen
