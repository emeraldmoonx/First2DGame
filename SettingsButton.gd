extends Button

# Declare variables
var settings_panel
var character
var message
var score
var start_button

func _ready():
	# Access nodes using correct paths
	settings_panel = get_node("/root/Main/HUD/SettingsPanel")
	character = get_node("/root/Main/Player")
	message = get_node("/root/Main/HUD/Message")
	score = get_node("/root/Main/HUD/ScoreLabel")
	start_button = get_node("/root/Main/HUD/StartButton")
	
	# Connect the pressed signal to the function using Callable
	connect("pressed", Callable(self, "_on_SettingsButton_pressed"))

func _on_SettingsButton_pressed():
	# Toggle the visibility of the settings panel
	settings_panel.visible = !settings_panel.visible
	
	# Toggle visibility of the character, message, score, and start button
	character.visible = !settings_panel.visible
	message.visible = !settings_panel.visible
	score.visible = !settings_panel.visible
	start_button.visible = !settings_panel.visible
