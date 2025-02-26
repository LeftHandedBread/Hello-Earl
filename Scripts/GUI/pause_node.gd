extends Control

@onready var settingsPanel = $Settings
@onready var mainPanel = $Main
var is_paused


#region Main Panel

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		if not is_paused:
			GameManager.player.set_physics_process(false)
			GameManager.player.inputEnabled = false
			is_paused = true
		
			match Input.mouse_mode:
				Input.MOUSE_MODE_CAPTURED:
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					self.show()
				Input.MOUSE_MODE_VISIBLE:
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
					self.hide()
		else:
			_unpause()


func _unpause() -> void:
	print("unpaused")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.player.set_physics_process(true)
	GameManager.player.inputEnabled = true
	self.hide()
	is_paused = false

func _settings() -> void:
	mainPanel.hide()
	settingsPanel.show()

func _quit() -> void:
	get_tree().change_scene_to_file("res://scenes/GUI/mainMenu.tscn")

func _actually_quit() -> void:
	get_tree().quit()

func _on_close_button() -> void:
	settingsPanel.hide()
	mainPanel.show() 


#endregion
