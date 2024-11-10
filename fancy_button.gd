extends ColorRect
@onready var color_rect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	size = Vector2(color_rect.size.x + 3, color_rect.size.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
