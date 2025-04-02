extends Node3D

@onready var ani = $rig/Skeleton3D/AnimationPlayer
@onready var coll = $StaticBody3D/CollisionShape3D

var tog = false

func _ready() -> void:
	fadeout()

func _process(delta: float) -> void:
	if GameManager.tower and tog:
		fadein()
		tog = !tog
	if !GameManager.tower and !tog:
		fadeout()
		tog = !tog


func fadein():
	ani.play("fade")
	coll.disabled = false
	print("manitower appeared")
	
func fadeout():
	ani.play_backwards("fade")
	coll.disabled = true
	print("manitower dissapeared")


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		fadeout()
		await ani.animation_finished
		$".".queue_free()
