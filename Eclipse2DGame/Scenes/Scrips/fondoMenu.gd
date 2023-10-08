extends ParallaxBackground

#Direccion en la que se mueve el fondo
var DIR = Vector2(1, 0)
var speed = 300

func _physics_process(delta):
	scroll_base_offset += DIR * speed * delta

# Esta función se ejecutará cuando se presione el botón "Play"
func _on_Jugar_pressed():	
	# Oculta la escena del menú (puedes personalizar esto según tu diseño)
	hide()
