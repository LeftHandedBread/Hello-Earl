extends Node

@onready var anim_player = $"."

func _ready():
	anim_player.get_animation("Day").loop = true
	anim_player.play("Day")
