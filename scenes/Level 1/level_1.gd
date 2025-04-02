extends Node3D

func _ready() -> void:
	GameManager.player.stairAssist(true)
#@export var target_fps: int = 30  # Desired FPS
#
#@onready var viewport := $"Day Cycle/WorldEnvironment/Node3D/DirectionalLight3D/MeshInstance3D/SubViewport" # Adjust the path
#@onready var timer := $"Day Cycle/WorldEnvironment/Node3D/DirectionalLight3D/MeshInstance3D/SubViewport/fps"  # Make sure this exists in the scene
#
#func _ready():
	#timer.wait_time = 1.0 / target_fps
	#timer.timeout.connect(_on_ViewportUpdateTimer_timeout)
	#timer.start()
#
#func _on_ViewportUpdateTimer_timeout():
	#viewport.render_target_update_mode = 4
	#await get_tree().process_frame  # Wait for a single frame update
	#viewport.render_target_update_mode = 0
	

func itsTime():
	get_tree().change_scene_to_file.bind("res://scenes/Sun Station/sun level.tscn").call_deferred()
