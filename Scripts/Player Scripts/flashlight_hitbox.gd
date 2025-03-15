extends Area3D

func _ready():
	monitoring = true
	monitorable = true
	add_to_group("flashlight beam")
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))

# Detect when a flashlight has collided
func _on_area_entered(body):
	if body.is_in_group("flashlight_interact"):
		body.illuminated = true
		body.toggle_illumination()
	else:
		print(body, "is not toggleable")

# Detect when a flashlight has left the collision bounds
func _on_area_exited(body):
	if body.is_in_group("flashlight_interact"):
		print(body, "is toggleable")
		body.illuminated = false
		body.toggle_illumination()
	else:
		print(body, "is not toggleable")
