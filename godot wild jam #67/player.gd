extends CharacterBody2D
signal infected
var startmoving = false
#var xright = 1550
#var xleft = -334
#var ytop = -450
#var ybottom = 1422
var can_move = true
#@export var ydistance = 98.4
#var eps = 1e-4 

# copy paste starting from here for grid stuff 
@onready var move_sound = $move_sound
@export var distance = 1900/18
var xoffset = 60 
var yoffset = 60 
func getGridPos(x=null, y=null): # defaults to current object's position 
	if (x == null): 
		x = position.x 
	if (y == null): 
		y = position.y 
	return Vector2i(round((x-xoffset)/distance), round((y-yoffset)/distance))  

func setGridPos(xgrid, ygrid): # only when teleporting or similar (instantaneous, no animation) 
	position.x = xoffset + distance*xgrid 
	position.y = yoffset + distance*ygrid

var xelast = 0.03 
var yelast = 0.03 
var animtime = 0.2 
var animprog = 0.0 

func moveGridPos(xg1, yg1, xgrid, ygrid, delta): # when moving (have animation) - doesn't check for collision 
	#position.x += (xoffset + distance*xgrid - position.x)*xelast 
	#position.y += (yoffset + distance*ygrid - position.y)*xelast 
	
	if (animprog < animtime): 
		var xgpos = (xgrid-xg1)*exp(-1.0*animprog/(xelast))*cos(2.5*PI*animprog/animtime) 
		var ygpos = (ygrid-yg1)*exp(-1.0*animprog/(yelast))*cos(2.5*PI*animprog/animtime) 
		position.x = xoffset + distance*(xgrid-xgpos) 
		position.y = yoffset + distance*(ygrid-ygpos)
		animprog += delta 
	else: 
		position.x = xoffset + distance*xgrid 
		position.y = yoffset + distance*ygrid
		animprog = 0 
	

# end of copy paste region for grid stuff 


var gridPos = Vector2i(0, 0)

func _ready(): 
	setGridPos(18, 0) 

var g1 = Vector2i(0, 0) 
var target = Vector2i(0, 0) 

func _physics_process(_delta):
	if WasSplashscreenShowed.is_it_enemy == false:
		startmoving = true
	#if abs(position.y - -56.4)<eps|| abs(position.y - 892.2)<eps:
		#ydistance = 111
	#if abs(position.y - 498.6)<eps|| abs(position.y - 1225.2)<eps:
		#ydistance = 98.4
	#if abs(position.x - 1220)<eps || abs(position.x - 914)<eps || abs(position.x - 596)<eps || abs(position.x - 388)<eps || abs(position.x - 180)<eps || abs(position.x - 138)<eps:
		#xdistance = 98
	#if abs(position.x - 1024)<eps || abs(position.x - 816)<eps || abs(position.x - 498)<eps || abs(position.x - 290)<eps || abs(position.x - 82)<eps:
		#xdistance = 110
	if startmoving == true and can_move == true:
		#print(g1.x, g1.y, target.x, target.y) 
		if (animprog>0): 
			if (animprog > animtime): 
				moveGridPos(g1.x, g1.y, target.x, target.y, _delta) 
				#animprog = 0 
			else: 
				moveGridPos(g1.x, g1.y, target.x, target.y, _delta) 
				#animprog += _delta 
		#print(animprog) 
				
		if $Timer.is_stopped(): 
			gridPos = getGridPos() # get grid position 
			if Input.is_action_just_pressed("move_up"):
				#position.y -= distance
				if gridPos.y < 1:
					return 
					#gridPos.y = 1
					
				g1 = Vector2(gridPos.x, gridPos.y)
				target = Vector2i(gridPos.x, gridPos.y-1) 
				
				moveGridPos(g1.x, g1.y, target.x, target.y, _delta) 
				move_sound.play()
				$Timer.start()
				
				#animprog += _delta 
			if Input.is_action_just_pressed("move_down"):
				#position.y+= distance
				if gridPos.y > 17:
					return 
					#gridPos.y = 17
					
				g1 = Vector2(gridPos.x, gridPos.y)
				target = Vector2i(gridPos.x, gridPos.y+1) 
				
				moveGridPos(g1.x, g1.y, target.x, target.y, _delta) 
				move_sound.play()
				$Timer.start()
				
				#animprog += _delta 
			if Input.is_action_just_pressed("move_left"):
				#position.x -= distance
				if gridPos.x < 1:
					return 
					#gridPos.x=1
				
				g1 = Vector2(gridPos.x, gridPos.y)
				target = Vector2i(gridPos.x-1, gridPos.y) 
				
				moveGridPos(g1.x, g1.y, target.x, target.y, _delta) 
				move_sound.play()
				$Timer.start()
				
				#animprog += _delta 
			if Input.is_action_just_pressed("move_right"):
				#position.x += distance
				if gridPos.x > 17:
					return 
					#gridPos.x = 17
					
				g1 = Vector2(gridPos.x, gridPos.y)
				target = Vector2i(gridPos.x+1, gridPos.y) 
				
				moveGridPos(g1.x, g1.y, target.x, target.y, _delta) 
				move_sound.play()
				$Timer.start()
				
				#animprog += _delta 

	#grid
	
	
	
func infection():
	startmoving = false
	emit_signal("infected")
	self.hide()
	setGridPos(18,0)
	$Sprite2D.texture = load("res://icon.svg")
	$Sprite2D.scale = Vector2(0.5,0.5) 
	await get_tree().create_timer(2.5).timeout
	self.show()
func infect_host():
	startmoving = false
