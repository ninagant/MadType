extends RichTextLabel
@onready var timer_display = $"../timerDisplay"
@onready var main_color = $"../mainColor"
@onready var game_screen = $".."
@onready var log_holder = $"../logHolder"
@onready var score_holder = $"../scoreHolder"

var entryAttempted : int
var streak : int
var offset = 20
var texts : Array
var isWrong
var prevIndex = -1
var currIndex
var timer : float

func _ready():
	texts = Reference.lines
	isWrong = false
	currIndex = 0
	timer = text.length() * 0.5
	entryAttempted = 1
	streak = 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	modulate = Color8(main_color.color.r8 + offset, main_color.color.g8 + offset/2, main_color.color.b8 + offset/3)
	timer_display.modulate = Color8(main_color.color.r8 + offset, main_color.color.g8 + offset/2, main_color.color.b8 + offset/3)
	#bg_color = Color8(main_color.color.r8 + offset, main_color.color.g8 + offset, main_color.color.b8 + offset)
	
	timer_display.text = String("%0.2f" % timer)
	
	if (text == "") || (isWrong):
		if (!isWrong):
			score_holder.score += 10 * streak
			streak += 1
		else:
			streak = 1
		log_holder.text += str(entryAttempted) + ") " + texts[prevIndex] + "\n"
		log_holder.entryCount += 1
		entryAttempted += 1
		while (prevIndex == currIndex):
			print(currIndex)
			print(prevIndex)
			currIndex = randi_range(0, texts.size()-1)
		if (Reference.mode == "no mercy"):
			text = texts[currIndex]
		else:
			var rand = randi_range(0, texts[currIndex].length() - 20)
			text = texts[currIndex].substr(rand, rand+20)
		match (Reference.mode):
			"time attack":
				if (!isWrong):
					timer += texts[currIndex].length() * 0.5
			"survival":
				timer = texts[currIndex].length() * 0.5
			"no mercy":
				if (!isWrong):
					timer += texts[currIndex].length() * 0.25
		prevIndex = currIndex
		isWrong = false
	
	if (timer < 0):
		isWrong = true
		game_screen.madStage += 0.5
		if (game_screen.madStage > 5):
			game_screen.gameOver = true
	
	if (!game_screen.gameOver):
		timer -= delta
	
