extends Area3D

@onready var gravcoll = $".."

func _ready():
	connect("body_entered", Callable(self, "_on_area_entered"))
	connect("body_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(body):
	gravcoll.gravity = -9.8 * 2

func _on_area_exited(body):
	gravcoll.gravity = 9.8 * 2
