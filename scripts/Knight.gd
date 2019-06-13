extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var vel_actual = Vector2()
export var speed = 200
export var jump = 160
var gravity = 200
var monedas = 0
var vidas = 4
#tamano de la pantalla
onready var sizeScreen = get_viewport().size

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#lo que quiero es que mi animacion dure hasta que toque el suelo,
	#uso variable en vez de numeros porque asi puedo modificar el salto independiente de su velocidad
	#y se va ajustar con el tamaño de la animacion
	get_node("AnimationPlayer").get_animation("jump").length = (-(-jump)/float(gravity))*2
	
	#Ajuste de camara sus limites para no desajustar el paisame
	#$Camera2D.limit_bottom = sizeScreen.y
	
	#Fue una prube para ver como funcionaban los grupos, cuando agregas a mas nodos con el mismo
	#nombre de grupo "player"
#	var gru = get_tree().get_nodes_in_group("player")[0]
#	print(gru.name)
#	for gru in get_tree().get_nodes_in_group("player"):
#		print(gru.name)
	pass

func _physics_process(delta):
	verica_si_no_ha_caido()
	#Esto era una prueba pra verificar en tiempo de ejecucion el salto conforme movia los valores
	#de jump para ver si se ajustaba bien la formaula, esto solo sirve si export la variable
	#get_node("AnimationPlayer").get_animation("jump").length = (-(-jump)/float(gravity))*2
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("idle")
		vel_actual.x = 0
		pass
	vel_actual.y += gravity * delta
	#print(vel_actual)
	leerTeclado(delta)
	#Esto es para saltar y moverte a hacia los lados en el aire y atacar
	if !is_on_floor():
		if Input.is_action_pressed("ui_right"):
			vel_actual.x = speed
		elif Input.is_action_pressed("ui_left"):
			vel_actual.x = -speed
		#Con esto atacas en el aire y dejas que termine la animacion
		if Input.is_action_pressed("tecla_space") and $AnimationPlayer.current_animation != "attack":
				$AnimationPlayer.play("attack")
		pass
	vel_actual = move_and_slide(vel_actual,Vector2(0,-1))

#Era un prueba para mejor el salto para el salto dure lo mismo que tiempo que la duracion
#Pero mejor hice medir cuanto tiempo tarda en saltar y llegar al suelo,con la formua de MRUA
# utilzando solamente calculos,  teniendo asi el tiempo para incrementar la animacion
#get_node("AnimationPlayer").get_animation("jump").length = (-(-jump)/float(gravity))*2
#	if is_on_floor() and $AnimationPlayer.current_animation == "jump":
#		#print("suelo")
#		$AnimationPlayer.stop(true)
#		pass
	
	pass


	
func leerTeclado(delta):
	
	if !$AnimationPlayer.is_playing() or $AnimationPlayer.current_animation == "idle":
		if Input.is_action_pressed("ui_right"):
			#$Sprite.flip_h = false
			$Sprite.scale.x = 1
			$AnimationPlayer.play("run")
			vel_actual.x = speed
			pass
		elif Input.is_action_pressed("ui_left"):
			#$Sprite.flip_h = true
			$Sprite.scale.x = -1
			$AnimationPlayer.play("run")
			vel_actual.x = -speed
			pass
		elif Input.is_action_just_pressed("tecla_space"):
			#$AnimationPlayer.play_backwards("attack")
			$AnimationPlayer.play("attack")
			pass

		
	if Input.is_action_pressed("ui_up") and is_on_floor() :
		$AnimationPlayer.play("jump")
		#vel_actual.y = -vel_desp * delta/ get_node("AnimationPlayer").get_animation("walk_up").length
		vel_actual.y = -jump 
		#print(get_node("AnimationPlayer").get_animation("jump").length)
		pass
	
	#Es es para conseguir el efecto de si lo presiona tan quedito se  hace toda la animacion y
	#todo el desplazamiento y eso no es lo que busco, con el if busque el efecto de 
	#avanzar con la animacion solamente conforme presiona el boton o tecla, dando sensibilidad
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		$AnimationPlayer.play("idle")
		vel_actual.x = 0
		pass
		
#	if Input.is_action_pressed("tecla_a"):
#		$AnimationPlayer.play("attack_especial")
#		pass

	pass


	

#Codigo para dectar las colisiones de la espada
func _on_SwordHit_body_entered(body):
	if body.is_in_group("hurtbox"):
		#print("golpe caja")
		body.take_damage()
	elif body.is_in_group("enemigo"):
		body.take_damage() #Funciones hechas por mi, para herir a los enemigos con la espada
	pass # replace with function body


func _on_AnimationPlayer_animation_finished(anim_name):
	#print(anim_name)
	if anim_name == "death":
		get_tree().change_scene("res://niveles/Nivel0.tscn")
#	if anim_name == "jump" and !is_on_floor():
#		print("Acabo la animacion pero no esta en el suelo")
		
	pass # replace with function body
	
func sumaMoneda():
	monedas += 1
	var labelGui = get_tree().get_nodes_in_group("label_monedas")[0]
	#get_tree().get_nodes_in_group("labelBarLife")[0]
	labelGui.text = String(monedas)
	#print(monedas)
	pass

func take_damage():
	get_tree().get_nodes_in_group("vida")[vidas-1].visible = false
	vidas -= 1
	if vidas == 0:
		#print("murio")
		$AnimationPlayer.play("death")
		#queue_free()
	pass
func verica_si_no_ha_caido():
	if global_position.y > 960:
		get_tree().change_scene("res://niveles/Nivel0.tscn")
	pass