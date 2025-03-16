extends Node3D

var inmine = false
var infinmine = false
var infinmineup = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if infinmine:
		if GameManager.isUpsideDown:
			if !infinmineup:
				print("player flipped in the mine ends")
				MusicTheme.minemu.set("parameters/switch_to_clip", "mineup")
				infinmineup = true
				$"finale mine".gravity_space_override = Area3D.SPACE_OVERRIDE_REPLACE 
		else:
			if infinmineup:
				$"finale mine".gravity_space_override = Area3D.SPACE_OVERRIDE_DISABLED 
				infinmineup = false


func _on_entering_mine_body_entered(body: Node3D) -> void:
	if inmine:
		return
	if body.is_in_group("player"):
		print("player in mines")
		inmine = true
		
		MusicTheme.fin = false
		MusicTheme.minemu.set("parameters/switch_to_clip", "mineamb")
		MusicTheme.down()


func _on_exiting_mine_body_entered(body: Node3D) -> void:
	if !inmine:
		return
	if body.is_in_group("player"):
		print("player left mines")
		inmine = false
		
		MusicTheme.minemu.set("parameters/switch_to_clip", "wind")
		MusicTheme.up()
		MusicTheme.fin = true


func _on_finale_mine_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !infinmineup:
		print("player is nearing the end of the mines")
		infinmine = true


func _on_leaving_mines_end_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and infinmine:
		print("player left the end area of the mines")
		infinmine = false
		if !MusicTheme.minemu.get("parameters/switch_to_clip") == "mineamb":
			MusicTheme.minemu.set("parameters/switch_to_clip", "mineamb")
