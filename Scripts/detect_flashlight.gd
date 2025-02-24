extends Area3D

@onready var detection_area = self  # Reference the detection area

func _ready():
	# Connects the player's detection area to a function that handles entered objects
	detection_area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("collision detected with body ", body)
	if body.is_in_group("flashlight"):
		self.get_parent().visible = true

func _on_body_exited(body):
	if body.is_in_group("flashlight"):
		self.get_parent().visible = false
