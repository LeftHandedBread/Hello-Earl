extends Interactible3D

func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		print("gravshoes Shoes Equipped")
		GameManager.characterShoes = GameManager.Shoes.GRAV
		self.get_parent().queue_free()
