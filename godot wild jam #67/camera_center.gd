extends Area2D

@onready var enemy = $"../enemy"
@onready var player = $"../player"
@onready var camera = $Camera2D
@onready var camera_center = $"."
@onready var innocent = $"../innocent"
# change these 
var xratio = 0.75 # have enemy and player x at least this far apart on the screen 
var yratio = 0.75 # have enemy and player y at least this far apart on the screen 
var xmin = 2000 # minimum x size of camera - to limit how much you zoom it (else it does a closeup of the stuff) 
var ymin = 1000 # minimum y size of camera - to limit how much you zoom it (else it does a closeup of the stuff) 

# ignore the below they won't have bug one (real) (not clickbait) (gone wrong) 

var temp = Vector2(0, 0)

var initxsize = 0 
var initysize = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	temp = camera.get_viewport_rect().size 
	initxsize = temp.x 
	initysize = temp.y 



# of player and enemy 
#var xs = [] 
#var ys = [] 

# unpacked to left and right 
var x1 = 0 
var x2 = 0 
var y1 = 0 
var y2 = 0 

# during calculation 
#var xoff = 0 
#var yoff = 0 

# final decision of camera 
#var xx1 = 0 
#var xx2 = 0 
#var yy1 = 0 
#var yy2 = 0 
var xsize = 0 
var ysize = 0 
var finalzoom = 0 
var centx = 0 
var centy = 0 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_instance_valid(player) and is_instance_valid(enemy)): 
		'''# get positions into list 
		xs = [player.global_position.x, enemy.global_position.x] 
		ys = [player.global_position.y, enemy.global_position.y] ''' 
		# separate into min max variables 
		if WasSplashscreenShowed.is_it_enemy: 
			x1 = min(player.global_position.x, enemy.global_position.x) 
			x2 = max(player.global_position.x, enemy.global_position.x) 
			y1 = min(player.global_position.y, enemy.global_position.y) 
			y2 = max(player.global_position.y, enemy.global_position.y) 
		else: 
			if player.startmoving == true:
				x1 = min(player.global_position.x, innocent.global_position.x) 
				x2 = max(player.global_position.x, innocent.global_position.x) 
				y1 = min(player.global_position.y, innocent.global_position.y) 
				y2 = max(player.global_position.y, innocent.global_position.y) 
		
		'''# calculate offsets  of camera edge 
		xoff = ((1-xratio)/2)*(x2-x1) 
		yoff = ((1-yratio)/2)*(y2-y1) 
		
		# calculate final camera border sizes 
		xx1 = x1 - xoff 
		xx2 = x2 + xoff 
		yy1 = y1 - yoff 
		yy2 = y2 + yoff
		'''
		
		# calculate final camera size 
		xsize = (1/xratio)*(x2-x1) 
		ysize = (1/yratio)*(y2-y1) 
		
		# clip 
		xsize = max(xsize, xmin) 
		ysize = max(ysize, ymin) 
		
		finalzoom = min(initxsize/xsize, initysize/ysize) 
		
		# set zoom of camera 
		camera.zoom = Vector2(finalzoom, finalzoom) 
		#print("CAMERA ZOOM:", camera.zoom)
		
		
		# calculate final center of camera 
		centx = (x1+x2)/2 
		centy = (y1+y2)/2 
		
		# set center of camera center 
		camera_center.global_position.x = centx 
		camera_center.global_position.y = centy 
		
		#print("CAMERA SCALE:", camera)

