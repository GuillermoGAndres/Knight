extends ParallaxBackground

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var SPEED = 10
var SPEED2 = 5
var SPEED3 = 7
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	$ParallaxClound.motion_offset.x += SPEED * delta
	$ParallaxRefleW.motion_offset.x += SPEED * delta
	$ParallaxSky1.motion_offset.x += SPEED * delta
	$ParallaxSky2.motion_offset.x += SPEED * delta

	pass
