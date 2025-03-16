extends Area3D

@onready var door_animation = $"../AnimationPlayer"
var isOpen = false
var illuminated = false

@onready var opensfx := $"../open"
@onready var closesfx := $"../close"

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


func _process(_delta: float) -> void:
	if GameManager.timeOfDay > .44 and GameManager.timeOfDay < .47 or illuminated:
		open_door()
	else:
		close_door()

		

func open_door():
	if !isOpen:
		door_animation.play("Open Door")
		isOpen = true
		opensfx.play()

func close_door():
	if isOpen:
		door_animation.play_backwards("Open Door")
		isOpen = false
		closesfx.play()
