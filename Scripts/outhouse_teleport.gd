extends Node

@onready var door_open = self.get_node("Node3D/Plane_001/Door Interact").door_open
@onready var player_present = self.get_node("Player Detector").player_present
@onready var parent = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	player_present = self.get_node("Player Detector").player_present
	door_open = self.get_node("Node3D/Plane_001/Door Interact").door_open
	
	if GameManager.timeOfDay > 0.25 and GameManager.timeOfDay < 0.4:
		if !player_present or !door_open:
			self.global_position = Vector3(41.685, 0.02, 20)
			self.global_rotation = Vector3(0, 20, 0)
		else:
			return
	else:
		if !player_present or !door_open:
			self.global_position = Vector3(41.5, 0.02, 22)
			self.global_rotation = Vector3(0, -90, 0)




func fade_in():
	# Iterate over all meshes and animate their materials' alpha to 1 (fully visible)
	for mesh_instance in find_all_mesh_instances(parent):
		if not mesh_instance.mesh:
			push_warning("MeshInstance3D has no mesh resource!")
			continue
		
		var surface_count = mesh_instance.mesh.get_surface_count()
		for i in range(surface_count):
			var mat = mesh_instance.get_surface_override_material(i)
			if not mat:
				push_warning("No material found on surface " + str(i) + " of " + mesh_instance.name)
				continue
			
			var new_tween = create_tween()  # Create a new tween for each material
			new_tween.tween_property(mat, "albedo_color:a", 1.0, 0.5)  # Fire it immediately


func fade_out():
	# Iterate over all meshes and animate their materials' alpha to 0 (fully transparent)
	for mesh_instance in find_all_mesh_instances(parent):
		if not mesh_instance.mesh:
			push_warning("MeshInstance3D has no mesh resource!")
			continue
		
		var surface_count = mesh_instance.mesh.get_surface_count() 
		for i in range(surface_count):
			var mat = mesh_instance.get_surface_override_material(i)
			if not mat:
				push_warning("No material found on surface " + str(i) + " of " + mesh_instance.name)
				continue
			
			var new_tween = create_tween()  # Create a new tween for each material
			new_tween.tween_property(mat, "albedo_color:a", 0.0, 0.5)  # Fire it immediately


func apply_material_override():
	if not parent:
		push_error("Mesh node is missing!")
		return
	
	# Find all MeshInstance3D nodes inside the inherited scene
	var mesh_instances = find_all_mesh_instances(parent)
	if mesh_instances.is_empty():
		push_error("No MeshInstance3D found inside the inherited scene!", parent.get_path())
		return
	
	# Apply overrides to all found meshes
	for mesh_instance in mesh_instances:
		if not mesh_instance.mesh:
			push_error("MeshInstance3D has no mesh resource!")
			continue
		
		# Loop through all surfaces of this mesh
		var surface_count = mesh_instance.mesh.get_surface_count()
		for i in range(surface_count):
			var original_material = mesh_instance.mesh.surface_get_material(i)
			if not original_material:
				push_warning("No material found on surface " + str(i) + " of " + mesh_instance.name)
				continue  # Skip if no material exists
			
			# Duplicate the material for override
			var override_material = original_material.duplicate()
			# Ensure material settings are correct
			override_material.transparency = 3 # Transparecy : alpha hash
			override_material.alpha_hash_scale = 0.4
			override_material.cull_mode = 2 # cull disabled
			override_material.depth_draw_mode = 1 # always
			override_material.shading_mode = 1 # per pixel
			override_material.diffuse_mode = 2 # lambert wrap
			override_material.specular_mode = 0 # SchlickGGX
			override_material.disable_ambient_light = true
			override_material.albedo_color.a = 1.0  # Start fully opaque
			override_material.albedo_color.r = 1.0  # Start fully red
			override_material.albedo_color.g = 1.0  # Start fully green
			override_material.albedo_color.b = 1.0  # Start fully blue
			
			# Apply the override material
			mesh_instance.set_surface_override_material(i, override_material)

# Helper function to find all MeshInstance3D nodes inside an inherited scene
func find_all_mesh_instances(mesh_parent: Node3D) -> Array:
	var meshes = []
	for child in mesh_parent.get_children():
		if child is MeshInstance3D:
			meshes.append(child)
		elif child is Node3D:  # Recursively search deeper
			meshes.append_array(find_all_mesh_instances(child))
	return meshes
