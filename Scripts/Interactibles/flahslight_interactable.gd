extends Interactible3D

@onready var toggle_mesh = get_parent().get_node("Cube") 

func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		print("Flashlight Found!")

	# Call the hide_mesh() function from the ToggleMesh script on the Cube node
	if toggle_mesh:
		toggle_mesh.hide_mesh()  # Hide the mesh
	
	GameManager.flashlight.enable_flashlight()
	CanInteract = false  # Prevent further interaction
	queue_free()  # Removes the object from the scene
