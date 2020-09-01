extends Control

export var name_prd  = "prod1"
export var multi: bool = true
export var dis = "Gives Additional amount ot health!"
export var price  = 0
export(Texture) var asset setget my_func

func _ready():
	$Label.text = name_prd
	$Label2.text = str(price) +" $"
signal clicked_




func my_func(tex):
	asset = tex
	get_node("TextureRect").texture = asset

func was_bought():
	$Check.visible = true
	$Button.disabled = true

func unbought():
	$Check.visible = false
	$Button.disabled = false
	
func _on_Button_pressed():
	
	Shop.get_node("STATUS").product_name = name_prd
	Shop.get_node("STATUS").prd_is_chosen = true
	Shop.get_node("STATUS").path_to_ico = $TextureRect.texture.resource_path
	Shop.get_node("STATUS").dis = dis
	Shop.get_node("STATUS").price = price
	
	var confirm = load("res://World/ConfirmWin.tscn").instance()
	get_tree().current_scene.add_child(confirm)
	
