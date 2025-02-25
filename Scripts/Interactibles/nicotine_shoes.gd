extends Interactible3D

func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		print("Marlboro Shoes Equipped")
		GameManager.characterShoes = GameManager.Shoes.NONE
		GameManager.characterShoes = GameManager.Shoes.NICOTINE


func _process(_delta: float) -> void:
	if GameManager.characterShoes == GameManager.Shoes.NICOTINE:
		self.get_parent().visible = false
	else:
		self.get_parent().visible = true
