extends Area2D
signal done
#@export var distance = 1900/18
#@export var ydistance = 98.4
var start = false
var rng = RandomNumberGenerator.new() 
@onready var audio_player = $audio_player
#var xright = 1550
#var xleft = -334
#var ytop = -450
#var ybottom = 1422
#var eps = 1e-4
#@onready var player = get_tree().get_root().get_node("Main.tscn/Player")


# copy paste starting from here for grid stuff 

@export var distance = 1900/18
var xoffset = 60 
var yoffset = 60 
func getGridPos(x=null, y=null): # defaults to current object's position 
	if (x == null): 
		x = position.x 
	if (y == null): 
		y = position.y 
	return Vector2i(round((x-xoffset)/distance), round((y-yoffset)/distance))  

func setGridPos(xgrid, ygrid): # only when teleporting or similar (ignores collision) 
	position.x = xoffset + distance*xgrid 
	position.y = yoffset + distance*ygrid

func moveGridPos(xgrid, ygrid): # when moving 
	position.x += xoffset + distance*xgrid - position.x 
	position.y += yoffset + distance*ygrid - position.y 

# end of copy paste region for grid stuff 


var enemyGridPos = Vector2i(0, 0) 
var playerGridPos = Vector2i(0, 0) 


func _ready(): 
	setGridPos(0, 18)

func _physics_process(_delta):
	var player = get_parent().get_node("player")
	#if abs(position.y - -56.4)<eps|| abs(position.y - 892.2)<eps:
		#ydistance = 111
	#if abs(position.y - 498.6)<eps|| abs(position.y - 1225.2)<eps:
		#ydistance = 98.4
	#if abs(position.x - 1220)<eps || abs(position.x - 914)<eps || abs(position.x - 596)<eps || abs(position.x - 388)<eps || abs(position.x - 180)<eps || abs(position.x - 138)<eps:
		#xdistance = 98
	#if abs(position.x - 1024)<eps || abs(position.x - 816)<eps || abs(position.x - 498)<eps || abs(position.x - 290)<eps || abs(position.x - 82)<eps:
		#xdistance = 110
	if start == true :
		if is_instance_valid(player):
			'''if $Timer.is_stopped():
				if ((global_position.x - player.global_position.x == 100) and (player.global_position.y + 100 == global_position.y)) || ((player.global_position.x - global_position.x == 100) and (player.global_position.y + 100 == global_position.y)):
					if player.global_position.y < global_position.y :
						position.y -= distance
						$Timer.start()
					elif player.global_position.y > global_position.y:
						position.y+= distance
						$Timer.start()
				elif player.global_position.x < global_position.x:
					position.x -= distance
					$Timer.start()
				elif player.global_position.x > global_position.x:
					position.x += distance
					$Timer.start() 
				elif player.global_position.y < global_position.y :
					position.y -= distance
					$Timer.start()
				elif player.global_position.y > global_position.y:
					position.y+= distance
					$Timer.start()'''
					
			if $Timer.is_stopped():
				enemyGridPos = getGridPos() 
				playerGridPos = getGridPos(player.global_position.x, player.global_position.y) 
				
				var xdiff = playerGridPos.x - enemyGridPos.x 
				var ydiff = playerGridPos.y - enemyGridPos.y 
				
				#var xdiff = round( (player.global_position.x - global_position.x)/distance )
				#var ydiff = round( (player.global_position.y - global_position.y)/distance ) 
				
				var xdirn = abs(xdiff) > abs(ydiff) 
				if (abs(xdiff) == abs(ydiff)): # add randomness when it's equal, to make it unpredictable 
					xdirn = (rng.randi_range(1,2) == 1) 
				
				if xdirn: 
					# move in x direction 
					#position.x += distance*(xdiff/abs(xdiff))
					moveGridPos(enemyGridPos.x + 2*int(xdiff > 0) - 1, enemyGridPos.y)  
				else: 
					# move in y direction 
					#position.y += distance*(ydiff/abs(ydiff)) 
					moveGridPos(enemyGridPos.x, enemyGridPos.y + 2*int(ydiff > 0) - 1)  
				audio_player.play()
				$Timer.start() 
	
	#grid
	#if global_position.x < xleft:
		#global_position.x = xleft
	#if global_position.x > xright:
		#global_position.x = xright
	#if global_position.y < ytop:
		#global_position.y = ytop
	#if global_position.y > ybottom:
		#global_position.y = ybottom


func _on_body_entered(body):
	start = false
	body.infection()
	await get_tree().create_timer(2).timeout
	emit_signal('done')
	queue_free()
'''
# outside everything 
var rng = RandomNumberGenerator.new() 

# in the thing 
			if $Timer.is_stopped():
				var xdiff = player.global_position.x - global_position.x 
				var ydiff = player.global_position.y - global_position.y 
				var xdirn = abs(xdiff) > abs(ydiff) 
				if (abs(xdiff) == abs(ydiff)): # add randomness when it's equal, to make it unpredictable 
					xdirn = rng.randi_range(1,2) == 1 
				if xdirn: 
					# move in x direction 
					position.x += distance*(xdiff/abs(xdiff))
				else: 
					# move in y direction 
					position.y += distance*(ydiff/abs(ydiff)) 
				$Timer.start() 
'''
