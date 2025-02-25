extends Area3D

@onready var animation = $"../SpotLight3D/AnimationPlayer"
var isOn = false
var illuminated = false


func _ready():
	monitoring = true
	monitorable = true  # Ensures this area can be detected by others
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))


func _on_area_entered(body):
	if body.is_in_group("flashlight beam"):
		illuminated = true


func _on_area_exited(body):
	if body.is_in_group("flashlight beam"):
		illuminated = false


func _process(delta: float) -> void:
	if GameManager.timeOfDay > .44 and GameManager.timeOfDay < .47 or illuminated:
		enable_illumination()
	else:
		disable_illumination()

		

func enable_illumination():
	if !isOn:
		animation.play("geode light")
		isOn = true

func disable_illumination():
	if isOn:
		animation.play_backwards("geode light")
		isOn = false
