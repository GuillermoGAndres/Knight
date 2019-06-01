extends ParallaxBackground



func _ready():

	var sizeScreenX = get_viewport().size.x
	
	var motionSky1 = 0.2
	var motionSky2 = 0.5
	var motionGrass1 = 0.9
	var motionGrass2 = 0.8
	var motionWater = 1.0
	var motionClounds = 0.2
	var motionReflecW = 0.2
	
	#Parallax_mirroring

	for parallax in get_children():
		#print(parallax.name)
		parallax.motion_mirroring.x = sizeScreenX
		pass
		
	#Parallax_motion
	
	$ParallaxSky1.motion_scale.x = motionSky1
	$ParallaxSky2.motion_scale.x = motionSky2
	$ParallaxGrass1.motion_scale.x = motionGrass1
	$ParallaxWater.motion_scale.x = motionWater
	$ParallaxGrass2.motion_scale.x = motionGrass2
	$ParallaxClound.motion_scale.x = motionClounds
	$ParallaxRefleW.motion_scale.x = motionReflecW
	
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
