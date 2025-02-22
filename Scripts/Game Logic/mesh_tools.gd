extends MeshInstance3D

# Function to hide the mesh
func hide_mesh() -> void:
	self.visible = false

# Function to show the mesh
func show_mesh() -> void:
	self.visible = true

func disbale_render() -> void:
	queue_free()  # Removes the object from the scene
