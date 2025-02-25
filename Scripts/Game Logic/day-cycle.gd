extends Node

@onready var anim_player = $"."
var time_of_day = 0.0
var is_reversed = false

func _ready():
	anim_player.get_animation("Day").loop = true
	anim_player.play("Day")
	set_animation_speed()  # Set initial animation speed

func _process(delta):
	GameManager.timeOfDay = time_of_day
	# Update time of day based on the time speed and whether it's reversed
	if is_reversed:
		time_of_day -= GameManager.timeSpeed * delta
	else:
		time_of_day += GameManager.timeSpeed * delta
	
	if Input.is_action_just_pressed("time warp"):
		GameManager.timeSpeed = 0.5
	if Input.is_action_just_released("time warp"):
		GameManager.timeSpeed = 0.002
	if Input.is_action_just_pressed("reverse warp"):
		GameManager.timeSpeed = -0.5
	if Input.is_action_just_released("reverse warp"):
		GameManager.timeSpeed = 0.002
	# Loop the day cycle
	if time_of_day > 1.0:
		time_of_day = 0.0
	elif time_of_day < 0.0:
		time_of_day = 1.0
	# Sync animation position to time_of_day
	anim_player.seek(time_of_day * anim_player.get_animation("Day").length)
	
	# Trigger events based on time_of_day thresholds
	#if time_of_day > 0 and time_of_day < 0.01:
		#trigger_morning_event()
	#elif time_of_day > 0.25 and time_of_day < 0.26:
		#trigger_noon_event()
	#elif time_of_day > 0.5 and time_of_day < 0.51:
		#trigger_evening_event()
	#elif time_of_day > 0.75 and time_of_day < 0.76:
		#trigger_midnight_event()

# Functions to trigger events at specific times of the day
#func trigger_morning_event():
	#print("Good morning!")

#func trigger_noon_event():
	#print("It's noon!")

#func trigger_evening_event():
	#print("Good evening!")

#func trigger_midnight_event():
	#print("It's Midnight!")

# Function to control animation speed dynamically
func set_animation_speed():
	anim_player.speed_scale = GameManager.timeSpeed  # Correct way to set speed

# Function to change the speed of the day cycle
func change_time_speed(new_speed: float):
	GameManager.timeSpeed = new_speed
	set_animation_speed()

# Function to reverse time direction
func reverse_time():
	is_reversed = !is_reversed
