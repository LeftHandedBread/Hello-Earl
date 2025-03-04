extends Interactible3D

@onready var spinning_light = $SpotLight3D
@onready var internal_light = $SpotLight3D2
var light_beam

enum LightBeam {
	RED = 0,
	WHITE = 1
}

func _ready():
	var light_beam = LightBeam.RED

func _interact():
	if Input.is_action_just_pressed("interact"):
		if GameManager.currentLightType == GameManager.Light.NORMAL and light_beam == LightBeam.RED:
			spinning_light.light_color = Color(1, 1, 1)
			internal_light.light_color = Color(1, 1, 1)
			GameManager.currentLightType = GameManager.Light.RED
		elif GameManager.currentLightType == GameManager.Light.RED and light_beam == LightBeam.WHITE:
			spinning_light.light_color = Color(1, 0.33, 0.07)
			internal_light.light_color = Color(1, 0.33, 0.07)
			GameManager.currentLightType = GameManager.Light.NORMAL
