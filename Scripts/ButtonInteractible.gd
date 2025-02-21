extends Interactible3D

@onready var door = get_tree().get_root().get_node("Node3D/TestPlace/DoorHinge")
@onready var animation_player = door.get_node("Door/OpenDoor")

var is_open : bool = false

# When the player interacts with the door
func open_door():
	if is_open:
		return  # If the door is already open, do nothing
	
	# Play the opening animation
	animation_player.play("Open Door")
	is_open = true  # Mark the door as open

# Reset the door (if you want to close it)
func close_door():
	if not is_open:
		return  # If the door is already closed, do nothing
	
	# Play the closing animation
	animation_player.play_backwards("Open Door")
	is_open = false  # Mark the door as closed


func _interact():
	if Input.is_action_just_pressed("interact"):
		if is_open:
			close_door()
		else:
			open_door()
			
