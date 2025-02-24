extends Node3D

@export var flashlight_area = GameManager.flashlight_hitbox 
@export var flashlight_on: bool = true # Variable to track if the flashlight is on or off
var mesh_instance: MeshInstance3D

func _ready():
	mesh_instance = $MeshInstance3D

	# Connect signals to handle flashlight detection
	#flashlight_area.connect("body_entered", self, "_on_flashlight_entered")
	#flashlight_area.connect("body_exited", self, "_on_flashlight_exited")

	# Update visibility based on the flashlight's initial state
	#update_visibility()

#func _process(delta):
	#if flashlight_on:
		#update_visibility() # Update visibility each frame if flashlight is on/off

func _on_flashlight_entered(body):
	if body == get_parent():  # Assuming the flashlight is attached to the player
		mesh_instance.visible = true

func _on_flashlight_exited(body):
	if body == get_parent():
		mesh_instance.visible = false

# This method updates the visibility based on whether the flashlight is on or not
#func update_visibility():
	#if flashlight_on and flashlight_area.is_colliding():
		#mesh_instance.visible = true
	#else:
		#mesh_instance.visible = false
