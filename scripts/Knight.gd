extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var vel_actual = Vector2()
export var speed = 200
export var jump = 150
var gravity = 200
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
	$Camera2D.limit_bottom = sizeScreen.y
	pass

func _physics_process(delta):
	
	#get_node("AnimationPlayer").get_animation("jump").length = (-(-jump)/float(gravity))*2
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("idle")
		vel_actual.x = 0
		pass
	vel_actual.y += gravity * delta
	#print(vel_actual)
	leerTeclado(delta)
	if !is_on_floor():
		if Input.is_action_pressed("ui_right"):
			vel_actual.x = speed
		elif Input.is_action_pressed("ui_left"):
			vel_actual.x = -speed
		if Input.is_action_pressed("tecla_space") and $AnimationPlayer.current_animation != "attack":
				$AnimationPlayer.play("attack")
		pass
	vel_actual = move_and_slide(vel_actual,Vector2(0,-1))

#	if is_on_floor() and $AnimationPlayer.current_animation == "jump":
#		#print("suelo")
#		$AnimationPlayer.stop(true)
#		pass
#	pass


	
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
		elif Input.is_action_pressed("tecla_space"):
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
	pass


	


func _on_SwordHit_body_entered(body):
	if body.is_in_group("hurtbox"):
		#print("golpe caja")
		body.take_damage()
	pass # replace with function body


func _on_AnimationPlayer_animation_finished(anim_name):
	#print(anim_name)
	
#	if anim_name == "jump" and !is_on_floor():
#		print("Acabo la animacion pero no esta en el suelo")
		
	
	
	pass # replace with function body
