extends Interactible3D

@onready var toyani := get_node("AnimationPlayer")

var running := false

func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		if !running:
			toyani.play("swing around")
		else:
			toyani.pause()
		running = !running
