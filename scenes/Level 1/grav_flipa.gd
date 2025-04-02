extends Area3D

@onready var timer = $"../../flipperfade"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.isUpsideDown:
		flipper(false)
		$CollisionShape3D.disabled = false
	else:
		flipper(true)
		$CollisionShape3D.disabled = true

func flipper(normal):
	if !normal and GameManager.player.feltGrav == Vector3(0, 9.8, 0):
		if GameManager.player.body.position >= Vector3(0, .95, 0):
			return
		if timer.time_left <= 0:
			timer.start()
		GameManager.player.body.position = Vector3(0, 1 - (timer.time_left / timer.wait_time), 0)
	else:
		if !GameManager.player.body.position <= Vector3(0, 0.05, 0):
			if timer.time_left <= 0:
				timer.start()
		GameManager.player.body.position = Vector3(0, timer.time_left / timer.wait_time, 0)
