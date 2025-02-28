extends WorldEnvironment

@export var max_fog_height: float = -50
@export var min_fog_height: float = -1024
@export var max_fog_energy: float = 0.77  # Max fog light energy at origin
@export var min_fog_energy: float = 0.0   # Min fog light energy at max distance
@export var max_sun_scatter: float = 0.09  # Max sun scatter at origin
@export var min_sun_scatter: float = 0.0  # Min sun scatter at max distance
@export var fade_start: float = 65.0  # Distance where drop-off begins
@export var fade_end: float = 75.0    # Distance where it reaches min values
@export var target_node: Node3D  # Assign your player or reference node

# Called every frame to update fog and sun scatter dynamically
func _process(delta: float) -> void:
	if not target_node or not environment:
		return

	var distance = target_node.global_position.length()  # Distance from world origin (0,0,0)

	var fog_energy = max_fog_energy
	var sun_scatter = max_sun_scatter
	var fog_height = max_fog_height

	if distance > fade_start:
		var t = (distance - fade_start) / (fade_end - fade_start)
		t = clamp(t, 0.0, 1.0)  # Ensure it's between 0 and 1
		fog_energy = lerp(max_fog_energy, min_fog_energy, t)
		sun_scatter = lerp(max_sun_scatter, min_sun_scatter, t)
		fog_height = lerp(max_fog_height, min_fog_height, t)

	environment.fog_light_energy = fog_energy
	environment.fog_sun_scatter = sun_scatter
	environment.fog_height = fog_height
