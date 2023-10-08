extends Control

# Esta función se ejecutará cuando se presione el botón "Play"
func _on_Jugar_pressed():
	# Carga la escena del juego
	var game_scene = preload("res://World.tscn")
	var game_instance = game_scene.instance()
	
	# Cambia a la escena del juego
	get_tree().get_root().add_child(game_instance)
	
	# Oculta la escena del menú (puedes personalizar esto según tu diseño)
	hide()

func _on_Historia_pressed():
	# Carga la escena del juego
	var game_scene = preload("res://World.tscn")
	var game_instance = game_scene.instance()
	
	# Cambia a la escena del juego
	get_tree().get_root().add_child(game_instance)
	
	# Oculta la escena del menú (puedes personalizar esto según tu diseño)
	hide()

func _on_Salir_pressed():
	get_tree().quit()



