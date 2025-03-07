extends CanvasLayer

@onready var Ani := get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioEngine.play_music(1)
	Ani.play("studiofade")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
