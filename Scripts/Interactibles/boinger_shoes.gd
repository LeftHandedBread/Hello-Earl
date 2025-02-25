extends Interactible3D

func _interact() -> void:
	if Input.is_action_just_pressed("interact"):
		print("Boingers Equipped")
		GameManager.characterShoes = GameManager.Shoes.NONE
		GameManager.characterShoes = GameManager.Shoes.COKE


func _process(_delta: float) -> void:
	if GameManager.characterShoes == GameManager.Shoes.COKE:
		self.get_parent().visible = false
