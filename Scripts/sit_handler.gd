extends Interactible3D

@export var sit_position: Node3D  # Position where the player will sit
var is_occupied: bool = false  # Tracks if the player is sitting

func _interact():
	if Input.is_action_just_pressed("interact"):
		if is_occupied:
			stand_up()
		else:
			sit_down()

func sit_down():
	if not is_occupied:
		is_occupied = true
		GameManager.player.sit(sit_position.global_transform)

func stand_up():
	if is_occupied:
		is_occupied = false
		GameManager.player.stand_up()
		
		
