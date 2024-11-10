extends RichTextLabel

var timerMimic : float
var switch : bool
# Called every frame. 'delta' is the elapsed time since the previous frame
func _ready():
	switch = false

func _process(delta):
	if (Input.is_anything_pressed()):
		switch = true
	if (switch):
		text = "%.2f" % timerMimic
