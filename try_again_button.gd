extends Button
@onready var block = $"../../transition_block"

func _pressed():
	var tween = create_tween()
	tween.tween_property(block, "position", Vector2(0,0), 0.25)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://game_screen.tscn")
