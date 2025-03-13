extends Node3D
@onready var ogpos = Vector3(25.9863, 0.90658, 21.1712)
@onready var ogrot = Vector3(-0.112692, -1.54408, 2.594548)

@onready var manipos = Vector3(25.7908, 0.731977, 19.9306)
@onready var manirot = Vector3(-0.112692, -1.54408, 1.337492)

func _ready():
	position = ogpos
	rotation = ogrot
	
func _process(delta: float) -> void:
	if GameManager.axe:
		position = manipos
		rotation = manirot
	if !GameManager.axe:
		position = ogpos
		rotation = ogrot
