extends Area3D

var isVis = false
var illuminated = false

@onready var paint := get_node("AnimationPlayer")
@onready var collider_parent = $"../StaticBody3D"


func _ready():
	monitoring = true
	monitorable = true  # Ensures this area can be detected by others
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))
	fade_out()

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
		#for shape in collider_parent.get_children():
			#if shape is CollisionShape3D:
				#shape.set_deferred("disabled", false)
	else:
		fade_out()
		#for shape in collider_parent.get_children():
			#if shape is CollisionShape3D:
				#shape.set_deferred("disabled", true)


func fade_out():
	paint.play("material change")
	print("fade in")
	illuminated = true



func fade_in():
	paint.play_backwards("material change")
	print("fade out")
	illuminated = false
