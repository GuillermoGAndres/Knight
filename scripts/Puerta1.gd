extends Area2D

var escNivel1 = preload("res://niveles/Nivel1.tscn")
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Puerta1_body_entered(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("cerrarPuerta")
	pass # replace with function body


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://niveles/Nivel1.tscn")
	pass # replace with function body
