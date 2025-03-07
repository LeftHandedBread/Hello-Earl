extends Interactible3D

func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		GameManager.currentLightType = GameManager.Light.NONE
		GameManager.currentLightType = GameManager.Light.NORMAL
		if GameManager.flashlightManager.flashlight_on:
			GameManager.flashlightManager.disable_flashlights()
		MusicTheme.finale()
		print("Normal Flashlight Found!")

func _process(_delta: float) -> void:
	if GameManager.currentLightType == GameManager.Light.NORMAL:
		self.get_parent().visible = false
	else:
		self.get_parent().visible = true
