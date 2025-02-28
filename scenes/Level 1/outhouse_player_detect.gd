extends Area3D

@export var player_present = false

func _ready():
	connect("body_entered", Callable(self, "_on_area_entered"))
	connect("body_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(body):
	print(body.name, " is in group: ", body.get_groups()) 
	if body.is_in_group("player"):
		player_present = true
		print("player detected")

func _on_area_exited(body):
	if body.is_in_group("player"):
		print("player left")
		player_present = false
