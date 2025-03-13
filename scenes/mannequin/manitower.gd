extends Node3D

@onready var ani = $rig/Skeleton3D/AnimationPlayer
@onready var coll = $StaticBody3D/CollisionShape3D

var tog = false

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
