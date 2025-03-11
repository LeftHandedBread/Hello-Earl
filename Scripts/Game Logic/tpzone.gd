extends Area3D

@export_range(0.0, 1.0) var active = 0.0
var present = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", Callable(self, "_on_area_entered"))
	connect("body_exited", Callable(self, "_on_area_exited"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and present :
		print("tping!")
		var roty = GameManager.player.global_rotation.y
		GameManager.player.set_global_transform(Transform3D(Basis(), Vector3.ZERO - Vector3(0, 0.2, 0)))
		GameManager.player.global_transform.basis = Basis.from_euler(Vector3(0, roty - $"..".global_rotation.y + 90, 0))

func _on_area_entered(body):
	print(body.name, " is in group: ", body.get_groups()) 
	if body.is_in_group("player"):
		present = true
		print("player detected in outhouse")

func _on_area_exited(body):
	if body.is_in_group("player"):
		present = false
		print("player left outhouse")
