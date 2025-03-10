class_name Interactable3D
extends Area3D

var current = 0

@onready var fl = $flashlight
@onready var rfl = $Node3D3

## Base for all objects that player can interact with by pressing E (or some other button)

## Text that shows up when player hovers over the Interactible3D
@export var InteractText : String = "Press [E] to interact"

## Self-explanatory. If you have eyes, you know what it does.
@export var CanInteract : bool = true

## Emitted when player presses the "interact" action while glazing at this beautiful Interactible3D
signal OnInteract


## Override function. Called when OnInteract is fired. Does nothing, since you're supposed to override it
func _interact() -> void:
	if GameManager.currentLightType == GameManager.Light.NORMAL and current == 0:
		fl.show()
		GameManager.currentLightType = GameManager.Light.NONE
		current = 1
	if GameManager.currentLightType == GameManager.Light.RED and current == 0:
		rfl.show()
		GameManager.currentLightType = GameManager.Light.NONE
		current = 2
	if GameManager.currentLightType == GameManager.Light.NORMAL and current == 2:
		fl.show()
		rfl.hide()
		GameManager.currentLightType = GameManager.Light.RED
		current = 1
	if GameManager.currentLightType == GameManager.Light.RED and current == 1:
		rfl.show()
		fl.hide()
		GameManager.currentLightType = GameManager.Light.NORMAL
		current = 2
	if GameManager.currentLightType == GameManager.Light.NONE and current == 1:
		fl.hide()
		GameManager.currentLightType = GameManager.Light.NORMAL
		current = 0
	if GameManager.currentLightType == GameManager.Light.NONE and current == 2:
		rfl.hide()
		GameManager.currentLightType = GameManager.Light.RED
		current = 0
	if GameManager.currentLightType == GameManager.Light.NONE and current == 0:
		print("SPAGHETTI")

func _ready() -> void:
	OnInteract.connect(_interact.bind())
	fl.hide()
	rfl.hide()
	
