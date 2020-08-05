extends Control

var MagazinTextNode
var GunDict

func _process(delta: float) -> void:
	GunDict = get_tree().root.get_child(1).get_node_or_null("Player").GunDict
	MagazinText()
	
func MagazinText():
	MagazinTextNode = get_node("MagazinText")
	var MagazinText = str(GunDict["RunTimeMagazinSize"]) + "/" + str(GunDict["MagazinSize"]) + " magazin \n lives: " + str(get_tree().root.get_child(1).get_node("Player").Lives)
	
	MagazinTextNode.set_text(MagazinText)
