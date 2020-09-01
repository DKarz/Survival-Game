extends Node

var product_name = ""
var prd_is_chosen = false
var bought = false
var path_to_ico = ""
var dis = ""
var player = null
var open = false
var buying = false
var price = 0
var wave = 0
var mobile = false

func _on_Exit_pressed():
	print("POP")
	open = false
	Shop.set_all_vis(false)
	buying = false
