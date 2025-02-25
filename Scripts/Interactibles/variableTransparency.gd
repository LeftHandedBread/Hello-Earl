extends MeshInstance3D

var r
var g
var b

@export var target: $head/flashlight/Cone_006 # The object to measure distance from
@export var mesh_instance: MeshInstance3D  # The object whose albedo will be changed
@export var min_color: Color = Color(r, g, b, 1) # Color at max distance
@export var max_color: Color = Color(r, g, b, 0)  # Color at min distance
@export var max_distance: float = 10.0  # The distance at which min_color is used



func _process(delta: float):
	if not target or not mesh_instance:
		return
	
	var distance = global_transform.origin.distance_to(target.global_transform.origin)
	var t = clamp(distance / max_distance, 0.0, 1.0)
	var new_color = min_color.lerp(max_color, 1.0 - t)
	
	var material = mesh_instance.get_surface_override_material(0)
	if material:
		material.albedo_color = new_color
