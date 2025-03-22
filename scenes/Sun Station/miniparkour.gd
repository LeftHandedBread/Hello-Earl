extends Node3D

@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$"../WorldEnvironment".environment.fog_enabled = false


func _on_area_3d_2_body_entered(body: Node3D) -> void:
	print("grow grow")
	if body.is_in_group("player"):
		player.secret(false)
		player.DEFAULT_SPEED = 12
		player.SPRINT_SPEED = 21.75
		player.CROUCH_SPEED = 4.5
		player.change_state(player.CharacterState.WALKING)
		var tween = create_tween()
		tween.tween_property(player, "scale", Vector3(3,3,3), 0.25)


func _on_area_3d_3_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.DEFAULT_SPEED = 4
		player.SPRINT_SPEED = 7.5
		player.CROUCH_SPEED = 2.5
		player.change_state(player.CharacterState.WALKING)
		var tween = create_tween()
		tween.tween_property(player, "scale", Vector3(1,1,1), 1)
