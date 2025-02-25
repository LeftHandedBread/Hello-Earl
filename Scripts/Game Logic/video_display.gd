extends Node


@onready var video_player = get_tree().get_root().get_node("/VideoStream")
func _ready():
	if video_player:
		var material = StandardMaterial3D.new()
		material.albedo_texture = video_player.get_texture() # Assign the video as a texture
		set_surface_override_material(0, material) # Apply to the first surface
		video_player.play() # Start playing
