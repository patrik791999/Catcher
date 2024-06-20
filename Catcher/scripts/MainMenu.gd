extends Control

@onready var instructions_popup = ConfirmationDialog.new()

func _ready():
	add_child(instructions_popup)
	instructions_popup.dialog_text = """
	Instructions:
	- Catch the good items to score points (books and chipsets).
	- Avoid the bad items to keep your lives (bombs).
	- For moving use left and right arrows.
	- And have fun !! :)
	"""
	
	$StartButton.connect("pressed", Callable(self, "_on_StartButton_pressed"))
	$InstructionsButton.connect("pressed", Callable(self, "_on_InstructionsButton_pressed"))
	$ExitButton.connect("pressed", Callable(self, "_on_ExitButton_pressed"))

func _on_StartButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Gameworld.tscn")

func _on_InstructionsButton_pressed():
	print("InstructionsButton pressed")
	instructions_popup.popup_centered()

func _on_ExitButton_pressed():
	get_tree().quit()
