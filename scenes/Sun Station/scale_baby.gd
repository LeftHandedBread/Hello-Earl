extends Node3D

@export var scaleInterval = 0.8
var scalvec = Vector3(scaleInterval, scaleInterval, scaleInterval)

@onready var timer = $"../scalerfade"
@onready var player = $"../Player"
@onready var wallColl = $brickwall/StaticBody3D/CollisionShape3D

var bing = false
var bop = false
var bigOlCount = 0

func _ready() -> void:
	$brickwall.apply(false)
	wallColl.disabled = true

func _process(_delta: float) -> void:
	pass


func _on_bing_body_entered(body: Node3D) -> void:
	if !body.is_in_group("player"):
		return
	print("binged")
	if bop:
		bop = false
		bigOlCount -= 1
		if bigOlCount == 0:
			$brickwall.apply(false)
			wallColl.call_deferred("set", "disabled", true)
		else:
			$brickwall.apply(true)
			wallColl.call_deferred("set", "disabled", false)
		print("binging")
		var tween = create_tween().set_parallel(true)
		tween.tween_property(player, "scale", player.scale * scalvec, 1.5)
		#tween.tween_property(player, "SPEED", player.SPEED - (player.DEFAULT_SPEED * scaleInterval/2), 1.5)
		#tween.tween_property(player, "DEFAULT_SPEED", player.DEFAULT_SPEED - (player.DEFAULT_SPEED * scaleInterval/2), 1.5)
		#tween.tween_property(player, "SPRINT_SPEED", player.SPRINT_SPEED - (player.SPRINT_SPEED * scaleInterval/2), 1.5)
		#tween.tween_property(player, "CROUCH_SPEED", player.CROUCH_SPEED - (player.CROUCH_SPEED * scaleInterval/2), 1.5)
		#tween.tween_property(player, "JUMP_VELOCITY", player.JUMP_VELOCITY - (player.JUMP_VELOCITY * scaleInterval/2), 1.5)
		return
	bing = true


func _on_bop_body_entered(body: Node3D) -> void:
	if !body.is_in_group("player"):
		return
	print("bopped")
	if bing:
		bing = false
		bigOlCount += 1
		if bigOlCount == 0:
			$brickwall.apply(false)
			wallColl.call_deferred("set", "disabled", true)
		else:
			$brickwall.apply(true)
			wallColl.call_deferred("set", "disabled", false)
		print("bopping")
		var tween = create_tween().set_parallel(true)
		tween.tween_property(player, "scale", player.scale / scalvec, 1.5)
		#tween.tween_property(player, "SPEED", player.SPEED + (player.DEFAULT_SPEED * scaleInterval/2), 1.5)
		#tween.tween_property(player, "DEFAULT_SPEED", player.DEFAULT_SPEED + (player.DEFAULT_SPEED * scaleInterval/2), 1.5)
		#tween.tween_property(player, "SPRINT_SPEED", player.SPRINT_SPEED + (player.SPRINT_SPEED * scaleInterval/2), 1.5)
		#tween.tween_property(player, "CROUCH_SPEED", player.CROUCH_SPEED + (player.CROUCH_SPEED * scaleInterval/2), 1.5)
		#tween.tween_property(player, "JUMP_VELOCITY", player.JUMP_VELOCITY + (player.JUMP_VELOCITY * scaleInterval/2), 1.5)
		return
	bop = true
