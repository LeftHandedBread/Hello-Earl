extends Camera3D

@onready var moving_object = get_parent().get_parent()

func _process(_delta):
	# Update the camera's position to follow the moving object
	self.global_transform.origin = moving_object.global_transform.origin
	self.global_transform.basis = moving_object.global_transform.basis
