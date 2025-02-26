extends Area3D

var isVis = false
var illuminated = false
@onready var collider_parent = $"../StaticBody3D"
@onready var fadeOut = $"../AnimationPlayer"

func _ready():
	monitoring = true
	monitorable = true
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))
	for shape in collider_parent.get_children():
		if shape is CollisionShape3D:
			shape.set_deferred("disabled", false)

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
		fade_out()
		for shape in collider_parent.get_children():
			if shape is CollisionShape3D:
				shape.set_deferred("disabled", true)
	else:
		fade_in()
		for shape in collider_parent.get_children():
			if shape is CollisionShape3D:
				shape.set_deferred("disabled", false)
				
func fade_in():
	if !isVis:
		fadeOut.play_backwards("fade_out")
		isVis = true

func fade_out():
	if isVis:
		fadeOut.play("fade_out")
		isVis = false
