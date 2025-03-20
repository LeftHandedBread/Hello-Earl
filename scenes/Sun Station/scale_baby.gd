extends Node3D

@export var scaleInterval = 0.2
var scalvec = Vector3(scaleInterval, scaleInterval, scaleInterval)

@onready var timer = $"../scalerfade"
@onready var player = $"../Player"

var bing = 0
var bop = 0

func _process(_delta: float) -> void:
	pass


func _on_bing_body_entered(body: Node3D) -> void:
	if !body.is_in_group("player"):
		return
	print("binged")
	if bop:
		print("binging")
		var tween = create_tween().set_parallel(true)
		tween.tween_property(player, "scale", player.scale - (player.scale * scalvec), 1.5)
		tween.tween_property(player, "DEFAULT_SPEED", player.DEFAULT_SPEED - (player.DEFAULT_SPEED * scaleInterval), 1.5)
		tween.tween_property(player, "SPRINT_SPEED", player.SPRINT_SPEED - (player.SPRINT_SPEED * scaleInterval), 1.5)
		tween.tween_property(player, "CROUCH_SPEED", player.CROUCH_SPEED - (player.CROUCH_SPEED * scaleInterval), 1.5)
		tween.tween_property(player, "JUMP_VELOCITY", player.JUMP_VELOCITY - (player.JUMP_VELOCITY * scaleInterval), 1.5)
		bop = 0
		return
	bing = 1


func _on_bop_body_entered(body: Node3D) -> void:
	if !body.is_in_group("player"):
		return
	print("bopped")
	if bing:
		print("bopping")
		var tween = create_tween().set_parallel(true)
		tween.tween_property(player, "scale", player.scale + (player.scale * scalvec), 1.5)
		tween.tween_property(player, "DEFAULT_SPEED", player.DEFAULT_SPEED + (player.DEFAULT_SPEED * scaleInterval), 1.5)
		tween.tween_property(player, "SPRINT_SPEED", player.SPRINT_SPEED + (player.SPRINT_SPEED * scaleInterval), 1.5)
		tween.tween_property(player, "CROUCH_SPEED", player.CROUCH_SPEED + (player.CROUCH_SPEED * scaleInterval), 1.5)
		tween.tween_property(player, "JUMP_VELOCITY", player.JUMP_VELOCITY + (player.JUMP_VELOCITY * scaleInterval), 1.5)
		bing = 0
		return
	bop = 1
