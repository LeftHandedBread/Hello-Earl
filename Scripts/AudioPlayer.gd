extends Node

# Declare AudioStreamPlayers

var b_cross_with_a : $b_cross_with_a
var c_loop : $c_loop
var d_transition : $d_transition

enum MusicState {
	A,
	B,
	C,
	D,
	E
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	b_cross_with_a = $b_cross_with_a
	c_loop = $c_loop
	d_transition = $d_transition

play_music(MusicState.AMBIENT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
