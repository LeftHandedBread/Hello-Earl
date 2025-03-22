extends Area3D

@onready var animation = $"../OmniLight3D/AnimationPlayer"
@onready var mechs = $"../../AnimationPlayer"

var isOn = false
var illuminated = false


func _ready():
	monitoring = true
	monitorable = true  # Ensures this area can be detected by others
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))


func _on_area_entered(body):
	print("entering:", body.name)
	if body.is_in_group("flashlight beam"):
		illuminated = true


func _on_area_exited(body):
	print("exiting:", body.name)
	if body.is_in_group("flashlight beam"):
		illuminated = false


func _process(_delta: float) -> void:
	if illuminated:
		enable_illumination()
	else:
		disable_illumination()

		

func enable_illumination():
	if !isOn:
		animation.play("geo_light")
		isOn = true
		mechs.play("mechs")

func disable_illumination():
	if isOn:
		animation.play_backwards("geo_light")
		isOn = false
		mechs.pause()
