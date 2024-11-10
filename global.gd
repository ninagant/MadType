extends Node

var mode : String
var score : int
var timeAttackSec = 100
var lines : Array

func _ready():
	lines = store_of_lines()

# Function to read lines from a file and store them in an Array
func store_of_lines() -> Array:
	var url = "res://CapitalOne.txt"  # Make sure the file is located in the "res://" directory
	var file = FileAccess.open(url, FileAccess.READ)  # Properly declare and initialize the File object
	
	var storage = Array()

	if FileAccess.open(url, FileAccess.READ) != null:
		while !file.eof_reached():
			var line = file.get_line()
			storage.append(line.to_lower())
		file.close()
	else:
		print("File not found or unable to open.")
	
	return storage
