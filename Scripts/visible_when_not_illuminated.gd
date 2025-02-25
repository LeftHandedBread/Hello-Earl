extends Area3D

var illuminated = false
@onready var collider_parent = $"../StaticBody3D"

func _ready():
	monitoring = true
	monitorable = true  # Ensures this area can be detected by others
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(body):
	print("Body entered well: ", body)
	if body.is_in_group("flashlight beam"):
		print("flashlight detected")
		illuminated = true
		toggle_illumination()


func _on_area_exited(body):
	print("Body exited well: ", body)
	if body.is_in_group("flashlight beam"):
		print("flashlight detected")
		illuminated = false
		toggle_illumination()


func toggle_illumination():
	print("illumination state toggled")
	if illuminated:
		self.get_parent().visible = false
		for shape in collider_parent.get_children():
			if shape is CollisionShape3D:
				shape.set_deferred("disabled", true)
	else:
		self.get_parent().visible = true
		for shape in collider_parent.get_children():
			if shape is CollisionShape3D:
				shape.set_deferred("disabled", false)
