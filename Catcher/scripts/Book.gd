extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position.y += randf_range(5,10)


func _on_area_entered(area):
	if area.name == "Player":
		get_tree().root.get_node("Gameworld").increase_score()
	queue_free()

