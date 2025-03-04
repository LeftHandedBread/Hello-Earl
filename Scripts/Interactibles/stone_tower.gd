extends Node3D
@onready var pulley := $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pulley.play("elevator")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
