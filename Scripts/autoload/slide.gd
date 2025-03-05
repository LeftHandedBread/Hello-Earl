extends Node3D
@onready var slide:= $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slide.play("slide")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
