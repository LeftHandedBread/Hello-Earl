extends Area3D

var isVis = false
var illuminated = false
@onready var collider_parent = $"../StaticBody3D"
@onready var fadeIn = $"../AnimationPlayer"

func _ready():
	monitoring = true
	monitorable = true  # Ensures this area can be detected by others
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))
	fade_out()
	for shape in collider_parent.get_children():
		if shape is CollisionShape3D:
			shape.set_deferred("disabled", true)

func _on_area_entered(body):
	if body.is_in_group("flashlight beam"):
		illuminated = true
		toggle_illumination()

func _on_area_exited(body):
	if body.is_in_group("flashlight beam"):
		illuminated = false
		toggle_illumination()


func toggle_illumination():
	if illuminated:
		fade_in()
		for shape in collider_parent.get_children():
			if shape is CollisionShape3D:
				shape.set_deferred("disabled", false)
	else:
		fade_out()
		for shape in collider_parent.get_children():
			if shape is CollisionShape3D:
				shape.set_deferred("disabled", true)
				
func fade_in():
	if !isVis:
		fadeIn.play("fade_in")
		isVis = true

func fade_out():
	if isVis:
		fadeIn.play_backwards("fade_in")
		isVis = false
