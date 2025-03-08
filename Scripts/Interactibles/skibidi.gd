extends Node3D

@export_range(0.0,1.0) var vis = 0.0
@onready var case = $Case
@onready var door = $Node3D/door
@onready var fade = $AnimationPlayer

var toggle = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if vis and toggle:
		fade.play_backwards("fade")
		toggle = false
	if !vis and !toggle:
		fade.play("fade")
		toggle = true
