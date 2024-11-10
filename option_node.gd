extends ColorRect
@onready var color_rect_3 = $ColorRect3

var defaultColor : Color
var dColor : Color

# Called when the node enters the scene tree for the first time.
func _ready():
	defaultColor = Color(0, 0.463, 1)
	dColor = defaultColor


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	color_rect_3.color = defaultColor
