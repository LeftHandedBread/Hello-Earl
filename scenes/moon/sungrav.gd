extends Area3D

@onready var coll = $CollisionShape3D
@onready var daycycle = $"../../../../../AnimationPlayer"
@onready var world = $"../../../.."
@onready var light = $"../.."
@onready var player = $"../../../../../../Player"
@onready var fadeout = $"../../../../../../fadeToSun"

var flipper = 1
var timeRun = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.sungrav:
		if !timeRun:
			$"../../../../../../Timer".start()
			timeRun = true
			preload("res://scenes/Sun Station/sun level.tscn")
				
		if $"../../../../../../Timer".time_left == 0:
			GameManager.player.velocity *= .9
			if GameManager.player.velocity.length() <= 4:
				$"../../../../../../Timer".start()
			
		GameManager.characterShoes = GameManager.Shoes.LEAD
		coll.disabled = false
		daycycle.pause()
		light.light_color = "c3d4f1"
		light.light_energy = 6
		world.environment.fog_light_energy = 0
		
		var distance = global_position.distance_to(player.global_position)
		
		set_gravity(flipper * (distance/100 + 16))
		
		print(GameManager.player.velocity)
		
		if distance < 75:
			fadeout.play("fade to sun")
			await fadeout.animation_finished
			$"../../../../../..".itsTime()
			
	if !GameManager.sungrav:
		coll.disabled = true


func _on_area_3d_2_body_entered(body: Node3D) -> void:
	flipper = -2


func _on_area_3d_2_body_exited(body: Node3D) -> void:
	flipper = 1
