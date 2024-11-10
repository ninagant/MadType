extends Node2D
var promptsPassed : int
var currentPrompt : String
var currentString : String
var madStage : float
var gameOver : bool
@onready var block = $transition_block
@onready var main_menu_button = $game_over_state_Stuff/main_menu_button
@onready var try_again_button = $game_over_state_Stuff/try_again_button
@onready var game_over_state_stuff = $game_over_state_Stuff
@onready var broken_glass = $broken_glass
@onready var game_over_text = $gameOverText
@onready var main_color = $mainColor
@onready var prompt_holder = $promptHolder
@onready var game_over_overlay = $game_over_overlay


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property(block, "position", Vector2(0,1000),0.25)
	game_over_text.visible = false
	game_over_text.modulate.a = 0
	game_over_overlay.visible = false
	game_over_overlay.color.a = 0
	gameOver = false
	promptsPassed = 0
	madStage = 0

func _unhandled_input(event):
	if event is InputEventKey and not event.is_pressed() and !gameOver:
		var typed_event = event as InputEventKey
		var key_typed = typed_event.as_text_key_label().to_lower()
		key_typed = handle_key_inputs(key_typed)
		
		if (key_typed != ""):
			if (key_typed == (prompt_holder.text.substr(0,1)) || ("!@#$$%^&*(){}|<>?/:").contains(prompt_holder.text.substr(0,1))):
				prompt_holder.text = prompt_holder.text.substr(1)
			else:
				madStage += 0.5
				if (madStage > 5):
					gameOver = true
				prompt_holder.isWrong = true
		
		


func handle_key_inputs(key_typed) -> String:
	if (key_typed.contains("shift+")):
		if (key_typed == "shift+slash"):
			return "?"
		if (key_typed == "shift+1"):
			return "!"
		return match_shift_symbols(key_typed.substr(6))
		key_typed.to_upper()
	else:
		key_typed = match_nonshift_symbols(key_typed)

	return key_typed
	
	
func match_nonshift_symbols(key_typed) -> String:
	match (key_typed):
		"space":
			key_typed = " "
		"quoteleft":
			key_typed = "`"
		"minus":
			key_typed = "-"
		"equal":
			key_typed = "="
		"bracketleft":
			key_typed = "["
		"bracketright":
			key_typed = "]"
		"semicolon":
			key_typed = ";"
		"comma":
			key_typed = ","
		"period":
			key_typed = "."
		"apostrophe":
			key_typed = "'"
		"slash":
			key_typed = "/"
		"shift":
			key_typed = ""
		"tab":
			key_typed = ""
		"capslock":
			key_typed = ""
		"ctrl":
			key_typed = ""
	return key_typed
func match_shift_symbols(key_typed) -> String:
	#is a symbol
	match (key_typed.substr(1)):
		"2":
			return "@"
		"3":
			return "#"
		"4":
			key_typed = "$"
		"5":
			key_typed = "%"
		"6":
			key_typed = "^"
		"7":
			key_typed = "&"
		"8":
			key_typed = "*"
		"9":
			key_typed = "("
		"0":
			key_typed = ")"
		"quoteleft":
			key_typed = "~"
		"minus":
			key_typed = "_"
		"equal":
			key_typed = "+"
		"bracketleft":
			key_typed = "{"
		"bracketright":
			key_typed = "}"
		"semicolon":
			key_typed = ":"
		"comma":
			key_typed = "<"
		"period":
			key_typed = ">"
			
	#wasnt a symbol; a letter
	key_typed = key_typed.substr(1,2).to_upper()
	return key_typed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!gameOver):
		handle_alive_gameplay()
	else:
		game_over_overlay.visible = true
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(broken_glass, "modulate:a", 0.75, 0.75)
		tween.tween_property(broken_glass, "scale", Vector2(1,1), 0.75)
		tween.tween_property(broken_glass, "position", Vector2(561,281), 0.75)
		tween.set_parallel(false)
		tween.tween_property(game_over_overlay, "color:a", 0.75, 1)
		game_over_text.visible = true
		tween.tween_property(game_over_text, "modulate:a", 1, 0.4)
		await get_tree().create_timer(0.5).timeout
		handle_game_over_state()
		

func handle_game_over_state():
	if game_over_state_stuff.is_inside_tree():
		var tween = create_tween()
		tween.tween_property(game_over_state_stuff, "position", Vector2(0,0), 0.5)
	else:
		print("game_over_state_stuff is not in the tree.")

func handle_alive_gameplay():
	var currentColor = main_color.color
	var assignedColor : Color
	
	var redValue = 0.125 + (madStage * 0.1935)
	var greenValue = 0.122 + (madStage * -0.00825)
	var blueValue = 0.32 + (madStage * -0.01025)
	
	assignedColor = Color(redValue, greenValue, blueValue)
	
	if (currentColor != assignedColor):
		var tween = create_tween();
		var timer = 0.25
		tween.tween_property(main_color, "color", assignedColor, timer)
		await get_tree().create_timer(timer).timeout
	
	main_color.color = assignedColor

