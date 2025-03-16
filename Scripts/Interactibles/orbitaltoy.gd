extends Interactible3D

@onready var toyani := get_node("AnimationPlayer")

var running := false

func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		if !running:
			MusicTheme.minemu.set("parameters/switch_to_clip", "minesol")
			toyani.play("swing around")
		else:
			MusicTheme.minemu.set("parameters/switch_to_clip", "mineup")
			toyani.pause()
		running = !running
