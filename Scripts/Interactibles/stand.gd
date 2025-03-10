extends Interactible3D

var current = 0

@onready var fl = $fl
@onready var rfl = $rfl
@onready var flcoll = $fl/Area3D/CollisionShape3D
@onready var rflcoll = $rfl/Area3D/CollisionShape3D

## Override function. Called when OnInteract is fired. Does nothing, since you're supposed to override it
func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		print("stand logic attempt")
		if GameManager.flashlightManager.flashlight_on:
			GameManager.flashlightManager.disable_flashlights()
			GameManager.flashlightManager.disable_colliders()
		if GameManager.currentLightType == GameManager.Light.NORMAL and current == 0:
			fl.show()
			flcoll.show()
			GameManager.currentLightType = GameManager.Light.NONE
			current = 1
			print("1 0")
			return
		if GameManager.currentLightType == GameManager.Light.RED and current == 0:
			rfl.show()
			rflcoll.show()
			GameManager.currentLightType = GameManager.Light.NONE
			current = 2
			print("2 0")
			return
		if GameManager.currentLightType == GameManager.Light.NORMAL and current == 2:
			fl.show()
			flcoll.show()
			rfl.hide()
			rflcoll.hide()
			GameManager.currentLightType = GameManager.Light.RED
			current = 1
			print("1 2")
			return
		if GameManager.currentLightType == GameManager.Light.RED and current == 1:
			rfl.show()
			rflcoll.show()
			fl.hide()
			flcoll.hide()
			GameManager.currentLightType = GameManager.Light.NORMAL
			current = 2
			print("2 1")
			return
		if GameManager.currentLightType == GameManager.Light.NONE and current == 1:
			fl.hide()
			flcoll.hide()
			GameManager.currentLightType = GameManager.Light.NORMAL
			current = 0
			print("0 1")
			return
		if GameManager.currentLightType == GameManager.Light.NONE and current == 2:
			rfl.hide()
			rflcoll.hide()
			GameManager.currentLightType = GameManager.Light.RED
			current = 0
			print("0 2")
			return
		if GameManager.currentLightType == GameManager.Light.NONE and current == 0:
			print("SPAGHETTI")
			return

func _ready() -> void:
	OnInteract.connect(_interact.bind())
	fl.hide()
	rfl.hide()
	
