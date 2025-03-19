extends Node3D

func itsTime():
	get_tree().change_scene_to_file.bind("res://scenes/Sun Station/sun level.tscn").call_deferred()
