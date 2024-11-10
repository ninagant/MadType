extends RichTextLabel
@onready var timer_display = $"../timerDisplay"
@onready var main_color = $"../mainColor"
@onready var game_screen = $".."
@onready var prompt_holder = $"../promptHolder"

var offset = 20
var score : int

func _ready():
	score = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	modulate = Color8(main_color.color.r8 + offset, main_color.color.g8 + offset/2, main_color.color.b8 + offset/3)
	text = "SCORE: " + str(score)
