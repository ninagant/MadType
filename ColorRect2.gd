extends ColorRect

@onready var color_rect = $"../mainColor"
var offset = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	color = color_rect.color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var redValue = color_rect.color.r8 + offset
	var greenValue = color_rect.color.g8 + offset/2
	var blueValue = color_rect.color.b8
	
	if (redValue <= 235):
		color.r8 = redValue
	color.g8 = greenValue
	color.b8 = blueValue
