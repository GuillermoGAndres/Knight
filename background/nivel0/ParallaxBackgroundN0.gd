extends ParallaxBackground

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var rapidez = 15

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	$stars.motion_offset.x += rapidez * delta
	pass