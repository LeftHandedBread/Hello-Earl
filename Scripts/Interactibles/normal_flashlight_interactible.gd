extends Interactible3D

var current = 1

@onready var fl = $"."

## Override function. Called when OnInteract is fired. Does nothing, since you're supposed to override it
func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		print("stand logic attempt")
		MusicTheme.finale()
		GameManager.solvedBasement = true
		if GameManager.hasSeenBedroom:
			GameManager.house = false
			GameManager.axe = true
		if GameManager.flashlightManager.flashlight_on:
			GameManager.flashlightManager.disable_flashlights()
			GameManager.flashlightManager.disable_colliders()
		if GameManager.currentLightType == GameManager.Light.NONE and current == 1:
			GameManager.currentLightType = GameManager.Light.NORMAL
			current = 0
			print("0 1")
			$"..".queue_free()
			return
		if GameManager.currentLightType == GameManager.Light.NORMAL and current == 1:
			print("SKIBIDI BIDEN HAS BEEN RELEASED!!!")
			$"..".queue_free()
			return
		if GameManager.currentLightType == GameManager.Light.NONE and current == 0:
			print("SPAGHETTI")
			return

func _ready() -> void:
	OnInteract.connect(_interact.bind())
	fl.hide()
	
