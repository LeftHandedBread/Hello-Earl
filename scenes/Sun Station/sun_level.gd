extends Node3D


func _ready() -> void:
	GameManager.sungrav = false
	GameManager.characterShoes = GameManager.Shoes.NONE
	GameManager.currentLightType = GameManager.Light.NORMAL
	GameManager.player.stairAssist(false)
	$AnimationPlayer.play("fade from sun")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("dayCycle")
