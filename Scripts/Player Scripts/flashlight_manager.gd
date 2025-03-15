extends Node3D


var flashlight_on = false
@onready var normal_flashlight = $"normal flashlight"
@onready var normal_flashlight_hitbox = $"normal flashlight/Cone_006/Area3D"
@onready var normal_flashlight_collider = $"normal flashlight/Cone_006/Area3D/CollisionShape3D"
@onready var red_flashlight = $"red flashlight"
@onready var red_flashlight_collider = $"red flashlight/Area3D2/CollisionShape3D"
@onready var dark_flashlight = $"dark flashlight"
@onready var dark_flashlight_hitbox = $"dark flashlight/Area3D"
@onready var dark_flashlight_collider = $"dark flashlight/Area3D/CollisionShape3D"


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("flashlight toggled, type: ", GameManager.currentLightType)
		if GameManager.currentLightType == GameManager.Light.NONE:
			print()
			return
		if GameManager.currentLightType == GameManager.Light.NORMAL:
			flashlight_on = !flashlight_on
			enable_normal_flashlight()
		if GameManager.currentLightType == GameManager.Light.RED:
			flashlight_on = !flashlight_on
			enable_red_flashlight()
		if GameManager.currentLightType == GameManager.Light.DARK:
			flashlight_on = !flashlight_on
			enable_dark_flashlight()


func enable_normal_flashlight():
	if flashlight_on :
		normal_flashlight.light_energy = 2
		normal_flashlight_collider.disabled = false
	else:
		normal_flashlight.light_energy = 0 
		normal_flashlight_hitbox.monitoring = true
		normal_flashlight_collider.disabled = true


func enable_red_flashlight():
	if flashlight_on :
		red_flashlight.light_energy = 2
		red_flashlight_collider.disabled = false
	else:
		red_flashlight.light_energy = 0
		red_flashlight_collider.disabled = true


func enable_dark_flashlight():
	if flashlight_on :
		dark_flashlight.light_energy = 2
		dark_flashlight_collider.disabled = false
	else:
		dark_flashlight.light_energy = 0 
		dark_flashlight_hitbox.monitoring = true
		dark_flashlight_collider.disabled = true


func disable_flashlights():
	normal_flashlight.light_energy = 0 
	red_flashlight.light_energy = 0 
	dark_flashlight.light_energy = 0 
	flashlight_on = false


func _ready():
	flashlight_on = false
	GameManager.flashlightManager = self
	GameManager.currentLightType = GameManager.Light.NONE
	normal_flashlight.light_energy = 0
	red_flashlight.light_energy = 0
	dark_flashlight.light_energy = 0
	normal_flashlight.visible = true
	red_flashlight.visible = true
	dark_flashlight.visible = true
	
func disable_colliders():
	normal_flashlight_collider.disabled = true
	dark_flashlight_collider.disabled = true
	red_flashlight_collider.disabled = true
	
