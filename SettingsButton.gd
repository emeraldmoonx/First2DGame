extends Button

# Declare variables
var settings_panel
var character
var message
var score
var start

func _ready():
	# Access nodes using absolute paths
	settings_panel = get_node("/root/Main/HUD/SettingsPanel")
	character = get_node("/root/Main/Player")
	message = get_node("/root/Main/HUD/Message")
	score = get_node("/root/Main/HUD/ScoreLabel")
	start = get_node("/root/Main/HUD/StartButton")

	# Connect the pressed signal to the function
	connect("pressed", Callable(self, "_on_SettingsButton_pressed"))

func _on_SettingsButton_pressed():
	character.visible = !settings_panel.visible
	message.visible = !settings_panel.visible
	score.visible = !settings_panel.visible
	start.visible = !start.visible
