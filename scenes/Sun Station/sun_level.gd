extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.sungrav = false
	GameManager.characterShoes = GameManager.Shoes.NONE
	GameManager.currentLightType = GameManager.Light.NORMAL
	GameManager.player.stairAssist(false)
	$AnimationPlayer.play("dayCycle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
