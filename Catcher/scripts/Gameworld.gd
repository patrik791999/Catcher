extends Node2D

var book = preload("res://scenes/book.tscn")
var bomb = preload("res://scenes/bomb.tscn")
var chipset = preload("res://scenes/chipset.tscn")
var t = 1.5  #Initial value of timer
var score = 0
var lives = 3
var game_paused = false


@onready var score_label = $ScoreLabel
@onready var lives_label = $LivesLabel
@onready var pause_menu = $PauseMenu/PauseMenuControl
@onready var pause_score_label = $PauseMenu/PauseMenuControl/ScoreLabel
@onready var pause_lives_label = $PauseMenu/PauseMenuControl/LivesLabel
@onready var pause_menu_music = $PauseMenu/PauseMenuControl/AudioMenu
@onready var item_timer = $Timer

func _ready():
	initialize_game()
	$MenuButton.connect("pressed", Callable(self, "_on_MenuButton_pressed"))
	$PauseMenu/PauseMenuControl/ResumeButton.connect("pressed", Callable(self, "_on_ResumeButton_pressed"))
	$PauseMenu/PauseMenuControl/ExitButton.connect("pressed", Callable(self, "_on_ExitButton_pressed"))
	pause_menu.visible = false
	print("Ready function executed")

func initialize_game():
	score = 0
	lives = 3
	game_paused = false
	update_labels()
	start_timer()
	
func start_timer():
	item_timer.start(t)

func _on_timer_timeout():
	if game_paused:
		return
	
	var screen = get_viewport_rect().size
	var positionItem = Vector2(randf_range(0, screen.x), -100)
	
	var good_items = [load("res://scenes/book.tscn"),load("res://scenes/chipset.tscn")]
	var bad_items = [load("res://scenes/bomb.tscn")]
	
	var item_type = randi() % 3
	var item
	if item_type < 2:
		item = good_items[randi() % good_items.size()].instantiate()
	else:
		item = bad_items[randi() % bad_items.size()].instantiate()

	item.position = positionItem

	add_child(item)
	
	start_timer()

func increase_score():
	$ItemCatched.play()
	score += 1
	update_labels()
	if score % 5 == 0:
		t = max(0.5, t - 0.1)  #Decreasing value of timer(no under 0,5s)
		item_timer.stop()
		start_timer()

func decrease_lives():
	$Explosion.play()
	lives -= 1
	update_labels()
	if lives <= 0:
		call_deferred("game_over")

func update_labels():
	score_label.text = "Score: " + str(score)
	lives_label.text = "Lives: " + str(lives)

func game_over():
	print("Game Over")
	Global.final_score = score
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
	
func _on_MenuButton_pressed():
	print("Menu button pressed")
	show_pause_menu()

func _on_ResumeButton_pressed():
	print("Resume button pressed")
	resume_game()

func _on_ExitButton_pressed():
	print("Exit button pressed")
	get_tree().quit()

func show_pause_menu():
	print("Showing pause menu")
	game_paused = true
	$Timer.stop()
	pause_menu_music.play()
	pause_score_label.text = "Score: " + str(score)
	pause_lives_label.text = "Lives: " + str(lives)
	pause_menu.visible = true
	get_tree().paused = true
	
func resume_game():
	print("Resuming game")
	game_paused = false
	$Timer.start(t)
	pause_menu_music.stop()
	pause_menu.visible = false
	get_tree().paused = false
