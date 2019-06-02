extends KinematicBody2D


var vidas = 5
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
#	for grupos in get_groups():
#		print(grupos)
	#print(vidas)
	pass
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	#Area de vison del enemigo para activar la animacion ataque
	#and $RayCastIzq.get_collider().name != "swordEnem" 
	if($RayCastIzq.is_colliding()) :
		var colider = $RayCastIzq.get_collider()
		#print(colider.name)
		#Primera alternativa conbinar los dos ifs
#		if(colider.is_in_group("player")):
#			print("jugador")
		#El inconveniente es que solo detecta de un lado que es la espada
#		if(colider.get_parent().get_parent().is_in_group("player")):
#			print("player")
		
		#Segunda alternativa y mejorada, fue agregar SwordHit al grupo player
		if(colider.is_in_group("player")):
			#print("izquierod player")
			
			if !$AnimationPlayer.is_playing():
				atacar()
	
	#PENDIENTE ARREGLARLO
	#Ya vi cual era el problema el raycast no puede detecctar mas de dos colisones es decir
	#primero estaba detectando el shape del enemigo, y luego cuando pasaba al raycsat no me dectectaba
	#al jugador porque esta ya detectando al shape del enemigo y ya no hacia caso a los demas shapes
	#que surgan
	elif $RayCastDer.is_colliding():
		var collider  = $RayCastDer.get_collider()
		#print(collider.name)
		if(collider.is_in_group("player")):
			#print("DERECHA player")
			#Solo se necesita un scale ya que  colisionar se volteara el personaje y y la derechar
			#vuelve ser derecha siempre
			scale.x *= -1
			if !$AnimationPlayer.is_playing():
				atacar()
		pass
	
	#print(scale)
	
	pass

func atacar():
	$AnimationPlayer.play("miino_attack")
	#$AnimationPlayer.autoplay = "miino_attack"
	pass

func take_damage():
	vidas -= 1
	#print(vidas)
	if(vidas == 0):
		#Reinicar vidas por si acaso sale un bug, mas vale prevenicr que lamentar
		vidas = 5
		#print("estoy muerto")
		queue_free()
	pass


