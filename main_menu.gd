extends Node2D
@onready var fade = $fade
@onready var stylized_block = $stylized_block
@onready var button_1 = $nodeInner
@onready var node_outer = $nodeInner/nodeOuter
@onready var label = $RichTextLabel3

@onready var output = "0120121021021020212"
@onready var button_2 = $nodeInner2
@onready var node_outer2 = $nodeInner2/nodeOuter

@onready var button_3 = $nodeInner3
@onready var node_outer3 = $nodeInner3/nodeOuter


@onready var color_rect_4 = $ColorRect4
@onready var color_rect_5 = $ColorRect5
@onready var credits_screen = $"Credits Screen"

@onready var cred_label = $"Credits Screen/RichTextLabel"
@onready var cred_label_2 = $"Credits Screen/RichTextLabel2"
@onready var cred_label_3 = $"Credits Screen/RichTextLabel3"
@onready var transit = $"Credits Screen/ColorRect"

@onready var mode_label = $RichTextLabel
@onready var mode_desc = $RichTextLabel2

var code = ""
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()
	

func load_game():
	if not transit.is_inside_tree() or not credits_screen.is_inside_tree():
		print("Nodes are not in the tree!")
		return
	
	cred_label.text = "Capital One Dash"
	await get_tree().create_timer(0.75).timeout
	var tween1 = create_tween()
	tween1.tween_property(transit, "position", Vector2(3000, 259), 0.25)
	cred_label.visible = false
	cred_label_2.visible = true
	cred_label_3.visible = true
	
	await get_tree().create_timer(0.75).timeout
	var tween2 = create_tween()
	tween2.tween_property(transit, "position", Vector2(-2000, 259), 0.15)
	cred_label_2.visible = false
	cred_label_3.visible = false
	
	await get_tree().create_timer(0.5).timeout
	var tween3 = create_tween()
	tween3.tween_property(credits_screen, "position", Vector2(0, 1000), 0.35)
	
	# Final tween for other elements, in parallel
	await get_tree().create_timer(1.5).timeout
	credits_screen.visible = false
	var tween4 = create_tween()
	tween4.set_parallel(true)
	
	if fade.is_inside_tree():
		tween4.tween_property(fade, "position", Vector2(291, -151), 0.5)
	if stylized_block.is_inside_tree():
		tween4.tween_property(stylized_block, "position", Vector2(113, -184), 0.6)
	if button_1.is_inside_tree():
		tween4.tween_property(button_1, "position", Vector2(28, 42), 0.7)
	if button_2.is_inside_tree():
		tween4.tween_property(button_2, "position", Vector2(128, 189), 0.75)
	if button_3.is_inside_tree():
		tween4.tween_property(button_3, "position", Vector2(220, 326), 0.8)
	if color_rect_4.is_inside_tree():
		tween4.tween_property(color_rect_4, "position", Vector2(-16, 459), 0.85)
	if color_rect_5.is_inside_tree():
		tween4.tween_property(color_rect_5, "position", Vector2(-16, 459), 0.875)
	if mode_label.is_inside_tree():
		tween4.tween_property(mode_label, "modulate:a", 1, 0.9)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("up")):
		index -= 1
		update_buttons()
	if (Input.is_action_just_pressed("down")):
		index += 1
		update_buttons()
	
	if (Input.is_action_just_pressed("control") and code.length() > 4 and code.substr(code.length()-5, code.length()) == "01021"):
		label.text = output
	
	if (Input.is_action_just_pressed("enter")):
		var tween = create_tween()
		credits_screen.visible = true
		match (index):
			0:
				Reference.mode = "time attack"
				tween.tween_property(node_outer, "color", Color(1,0,0), 0.15)
				tween.tween_property(node_outer, "color", Color(0,0,1), 0.15)
				tween.tween_property(node_outer, "color", Color(1,0,0), 0.15)
				tween.tween_property(node_outer, "color", Color(0,0,1), 0.15)
				tween.tween_property(credits_screen, "position", Vector2(0,0), 0.25)
				await get_tree().create_timer(1.5).timeout
				get_tree().change_scene_to_file("res://game_screen.tscn")
			1:
				Reference.mode = "survival"
				tween.tween_property(node_outer2, "color", Color(1,0,0), 0.15)
				tween.tween_property(node_outer2, "color", Color(0,0,1), 0.15)
				tween.tween_property(node_outer2, "color", Color(1,0,0), 0.15)
				tween.tween_property(node_outer2, "color", Color(0,0,1), 0.15)
				tween.tween_property(credits_screen, "position", Vector2(0,0), 0.25)
				await get_tree().create_timer(1.5).timeout
				get_tree().change_scene_to_file("res://game_screen.tscn")
			2:
				Reference.mode = "no mercy"
				tween.set_parallel(true)
				tween.tween_property(node_outer3, "color", Color(0,0,1), 0.6)
				tween.tween_property(node_outer, "color", Color(0.67,0,0), 0.6)
				tween.tween_property(node_outer2, "color", Color(0.67,0,0), 0.6)
				tween.tween_property($ColorRect, "modulate", Color(0.67,0,0), 0.6)
				tween.tween_property(fade, "color", Color(0.67,0,0), 0.6)
				tween.tween_property(stylized_block, "color", Color(0.67,0,0), 0.6)
				tween.set_parallel(false)
				tween.tween_property(credits_screen, "position", Vector2(0,0), 0.25)
				await get_tree().create_timer(1.5).timeout
				if (code == output): get_tree().change_scene_to_file("res://mks.tscn")
				else :get_tree().change_scene_to_file("res://game_screen.tscn")
	

func update_buttons():
	if (index > 2):
		index = 0
	if (index < 0):
		index = 2
	code += str(index)
	if (code.length() > output.length()): 
		code = code.substr(1)
	var defaultColor = Color8(0, 118, 255)  # Default color for unselected buttons
	var selectedColor = Color8(255, 255, 0)  # Color for selected button
	match(index):
		0:
			node_outer.color = selectedColor
			node_outer2.color = defaultColor
			node_outer3.color = defaultColor
			mode_desc.text = "TIME ATTACK"
		1:
			node_outer.color = defaultColor
			node_outer2.color = selectedColor
			node_outer3.color = defaultColor
			mode_desc.text = "SURVIVAL"
		2:
			node_outer.color = defaultColor
			node_outer2.color = defaultColor
			node_outer3.color = selectedColor
			mode_desc.text = "NO MERCY"

