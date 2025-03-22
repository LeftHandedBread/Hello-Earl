extends Node3D


func _ready() -> void:
	GameManager.sungrav = false
	GameManager.characterShoes = GameManager.Shoes.SUN
	GameManager.currentLightType = GameManager.Light.NORMAL
	GameManager.player.stairAssist(false)
	GameManager.player.reset_shoe_effects()
	$AnimationPlayer.play("fade from sun")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("dayCycle")
	$"magic material/dark platties/AnimationPlayer".play("swang")
	$WorldEnvironment.environment.fog_enabled = false


func goodbye():
	for child in get_children():
		if !child == $Player and !child == $WorldEnvironment and !child == $AnimationPlayer:
				child.queue_free()
