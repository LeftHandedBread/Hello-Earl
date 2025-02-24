extends SpotLight3D

var flashlight_on = false
var can_use_flashlight = false  # Player must find it first
@onready var flashlight_collider = $Cone_006/Area3D/CollisionShape3D

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_F and can_use_flashlight:
		flashlight_on = !flashlight_on
		if flashlight_on :
			self.light_energy = 2
			flashlight_collider.disabled = false
		elif !flashlight_on :
			self.light_energy = 0 
			flashlight_collider.disabled = true
		print("Flashlight Toggle")

func enable_flashlight():
	can_use_flashlight = true
	self.visible = true
	print("Flashlight acquired!")

func _ready():
	GameManager.flashlight = self  # Register the flashlight globally
	self.visible = false  # Start hidden
