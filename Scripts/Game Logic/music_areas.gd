extends Node3D

var inmine = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_entering_mine_body_entered(body: Node3D) -> void:
	if inmine:
		return
	if body.is_in_group("player"):
		print("player in mines")
		inmine = true
		
		MusicTheme.fin = false
		MusicTheme.minemu.set("parameters/switch_to_clip", "mineamb")
		MusicTheme.down()

func _on_exiting_mine_body_exited(body: Node3D) -> void:
	if !inmine:
		return
	if body.is_in_group("player"):
		print("player left mines")
		inmine = false
		
		MusicTheme.minemu.set("parameters/switch_to_clip", "wind")
		MusicTheme.up()
		MusicTheme.fin = true
