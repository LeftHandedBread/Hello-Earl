extends Node3D
@onready var pulley := $AnimationPlayer

var shineBrightLikeADiamond = false
var shining = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if shineBrightLikeADiamond and !shining:
		pulley.play("elevator")
		shining = true
		
	if !shineBrightLikeADiamond and shining:
		pulley.pause()
		shining = false

func shineBrightBaby(yas):
	if yas:
		shineBrightLikeADiamond = 1
	if !yas:
		shineBrightLikeADiamond = 0
