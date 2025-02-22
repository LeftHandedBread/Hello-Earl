extends SpotLight3D

var flashlight_on = false
# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_F:
		flashlight_on = !flashlight_on
		if flashlight_on :
			self.light_energy = 2
		elif !flashlight_on :
			self.light_energy = 0 
		
