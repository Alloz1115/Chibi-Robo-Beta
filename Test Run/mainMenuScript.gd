extends Control
# Called when the node enters the scene tree for the first time.
func _ready():
	$vButton/startButton.grab_focus()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_credits_button_pressed():
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/credits.dialogue"))

func _on_quit_button_pressed():
	get_tree().quit()
