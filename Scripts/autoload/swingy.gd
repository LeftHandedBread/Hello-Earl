extends Node3D
@onready var swing := $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	swing.play("swing")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
