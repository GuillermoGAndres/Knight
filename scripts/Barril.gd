extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var vidas = 3 
func _ready():
	#print(vidas)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func take_damage():
	vidas = vidas - 1
	if vidas == 0:
		$AnimationPlayer.play("dead")
		return 0
	$AnimationPlayer.play("damage")
	#print(vidas)
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	#print(anim_name)
	if ( anim_name == "dead" ): 
		vidas = 3 #regreso las vidas como al inicio, para prevenir cualquier bug
		queue_free()
	
	pass # replace with function body
