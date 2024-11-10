extends AnimatedSprite2D

@onready var main_color = $"../mainColor"
@onready var game_screen = $".."

var colorOff = 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (game_screen.gameOver):
		stop()
	modulate.r8 = main_color.color.r8 + colorOff
	modulate.g8 = main_color.color.g8 + colorOff
	modulate.b8 = main_color.color.b8 + colorOff
