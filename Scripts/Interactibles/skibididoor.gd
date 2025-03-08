extends Area3D

@onready var swing = $AnimationPlayer
var isLit = false
var isOpen = false

func _ready():
	monitoring = true
	monitorable = true  # Ensures this area can be detected by others
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(body):
	if body.is_in_group("flashlight beam"):
		isLit = true


func _on_area_exited(body):
	if body.is_in_group("flashlight beam"):
		isLit = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if isLit:
		open_door()
	else:
		close_door()

func open_door():
	if !isOpen:
		swing.play("swing")
		isOpen = true

func close_door():
	if isOpen:
		swing.play_backwards("swing")
		isOpen = false
