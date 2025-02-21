extends Node

## Handles the settings file, applying settings everywhere, etc

var SettingsDict : Dictionary

const SETTINGS_FILE_PATH = "user://settings.sav"
const DEFAULT_SETTINGS = {"resolution": [1152, 648], "vsync": true, "fullscreen": false, "volume" : 1} # Settings that are set by default, in case if settings file does not exist

func _ready():
	await _load_settings()
	_apply_settings()

## Gets a value from SettingsDict. If it doesn't exist, it takes one from DEFAULT_SETTINGS.
## It's recommended to use this instead of reading data from SettingsDict directly, since it has a fallback in form of DEFAULT_SETTINGS.
func get_value(value_key : String):
	if not value_key in SettingsDict:
		return DEFAULT_SETTINGS[value_key]
	return SettingsDict[value_key]

## Applies settings from SettingsDict
func _apply_settings():
	DisplayServer.window_set_size(Vector2(SettingsDict.resolution[0], SettingsDict.resolution[1]))
	
	var screen_index = 0  # Set the desired screen index
	if screen_index >= DisplayServer.get_screen_count():
		screen_index = 0  # Default to the first screen if the index is out of range
	
# Get screen size and position
	var screen_position = DisplayServer.screen_get_position(screen_index)
	var screen_size = DisplayServer.screen_get_size(screen_index)
	
	# Calculate the window position to center it on the selected screen
	var window_size = DisplayServer.window_get_size()
	var window_pos = Vector2.ZERO
	window_pos.x = screen_position.x + (screen_size.x / 2 - window_size.x / 2)
	window_pos.y = screen_position.y + (screen_size.y / 2 - window_size.y / 2)
	
	# Set window position
	DisplayServer.window_set_position(window_pos)
	
	if SettingsDict.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
	
	if SettingsDict.vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(get_value("volume")))

## Loads settings from settings file
func _load_settings():
	var file = FileAccess.open(SETTINGS_FILE_PATH, FileAccess.READ)
	if file == null:
		SettingsDict = DEFAULT_SETTINGS
		_save_settings()
		return
	SettingsDict = JSON.parse_string(file.get_as_text())

## Saves settings in settings file
func _save_settings():
	var file = FileAccess.open(SETTINGS_FILE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(SettingsDict))
	return

func _get_resolution_as_str():
	return str(SettingsDict.resolution[0]) + "x" + str(SettingsDict.resolution[1])
