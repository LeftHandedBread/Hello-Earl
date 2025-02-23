extends Interactible3D

var is_washing: bool = false 
var is_clean: bool = false 
func _interact():
	if Input.is_action_just_pressed("interact"):
		if is_dirty:
			clean_laundry()
			

func clean_laundry():
	
