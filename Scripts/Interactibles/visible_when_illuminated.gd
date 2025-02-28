extends Area3D

var isVis = false
var illuminated = false

@onready var parent = self.get_parent_node_3d()
@onready var collider_parent = $"../StaticBody3D"
var tween


func _ready():
	monitoring = true
	monitorable = true  # Ensures this area can be detected by others
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))
	apply_material_override()
	fade_out()
	for shape in collider_parent.get_children():
		if shape is CollisionShape3D:
			shape.set_deferred("disabled", true)

# Detect when a flashlight has collided
func _on_area_entered(body):
	if body.is_in_group("flashlight beam"):
		illuminated = true
		toggle_illumination()

# Detect when a flashlight has left the collision bounds
func _on_area_exited(body):
	if body.is_in_group("flashlight beam"):
		illuminated = false
		toggle_illumination()


func toggle_illumination():
	if illuminated:
		fade_in()
		print("fading in", parent.get_path())
		for shape in collider_parent.get_children():
			if shape is CollisionShape3D:
				shape.set_deferred("disabled", false)
	else:
		fade_out()
		print("fading out", parent.get_path())
		for shape in collider_parent.get_children():
			if shape is CollisionShape3D:
				shape.set_deferred("disabled", true)


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
