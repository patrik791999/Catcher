extends Control

var final_score = 0

@onready var score_label = $ScoreLabel

func _ready():
	$RestartButton.connect("pressed", Callable(self, "_on_RestartButton_pressed"))
	$ExitButton.connect("pressed", Callable(self, "_on_ExitButton_pressed"))
	score_label.text = "Score: " + str(Global.final_score)

func _on_RestartButton_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()
