extends Node
@onready var final_label: Label = $FinalLabel

var score = 0

func collect_coin():
	score += 1
	final_label.text = "Congratulations \n You collected " + str(score) + " coins!"
