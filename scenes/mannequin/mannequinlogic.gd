extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.axe = false
	GameManager.house = true
	GameManager.tower = false
	GameManager.tree = false
	GameManager.well = false

var hasaxed = false

#region

func _on_bedroom_area_exited(area: Area3D) -> void:
	GameManager.hasSeenBedroom = true
	if GameManager.solvedBasement:
		GameManager.house = false
		GameManager.axe = true

func _on_axeyard_area_exited(area: Area3D) -> void:
	if GameManager.hasSeenBedroom and GameManager.solvedBasement:
		GameManager.axe = false
		if !hasaxed:
			GameManager.well = true
			GameManager.tower = true
			GameManager.tree = true
			hasaxed = true


func _on_wellhole_area_entered(area: Area3D) -> void:
	GameManager.well = false


func _on_lightroom_area_exited(area: Area3D) -> void:
	GameManager.tower = false


func _on_treeplatty_area_exited(area: Area3D) -> void:
	GameManager.tree = false


#endregion
