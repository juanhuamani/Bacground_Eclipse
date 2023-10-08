extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		# Retorna un booleano contrario al resultado anterior, ejemplo de true a false y viceversa	
		get_tree().paused = not get_tree().paused
		$Popup.visible = not $Popup.visible


func _on_Button_pressed() -> void:
	get_tree().change_scene("res://ControlMenu.tscn")
	print("Cambio escena")
