extends Interactible3D

@onready var collider = $"../StaticBody3D/CollisionShape3D"
@onready var sit_position = $"../Node3D"
var is_occupied = false  # Tracks if the player is sitting


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("flashlight"):
		stand_up()


func _interact():
	if Input.is_action_just_pressed("interact"):
		if is_occupied:
			stand_up()
		else:
			sit_down()


func sit_down():
	is_occupied = true
	collider.disabled = true
	GameManager.player.sit(sit_position)
	GameManager.timeSpeed = 0.02


func stand_up():
	is_occupied = false
	collider.disabled = false
	GameManager.player.stand_up()
	GameManager.timeSpeed = 0.002
