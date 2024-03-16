extends Area2D
@onready var player = $"../../../player"
@onready var radical = $"detection area"
#@export var speed = 5
#var right_angle = 1
#var rotate_speed = 10
#var waiting = false
#func _physics_process(delta):
	#await get_tree().create_timer(1).timeout
	#if ! waiting:
		#move()
func _physics_process(delta):
	pass
	
#func move():
	#waiting = true
	#while position.x != 953:
		#global_position.x += speed
		#await get_tree().create_timer(0.01).timeout
	#await get_tree().create_timer(1).timeout
	#rotation += right_angle*rotate_speed
	#await get_tree().create_timer(1).timeout
	#while position.x != 553:
		#global_position.x -= speed
		#await get_tree().create_timer(0.01).timeout
	#await get_tree().create_timer(2).timeout
	#while rotation != 0:
		#global_rotation += right_angle
	#await get_tree().create_timer(2).timeout
	#waiting = false
#func _ready():
	#global_position.x = 553
	#global_position.y = 548
	#global_rotation = 0
#func _physics_process(delta):
	#global_position.x += speed*delta
	#await get_tree().create_timer(1*delta).timeout
	#global_rotation += right_angle*delta
	#await get_tree().create_timer(1*delta).timeout
	#global_position.x -= speed*delta
	#await get_tree().create_timer(2*delta).timeout
	#global_rotation -= right_angle*delta
	#await get_tree().create_timer(2*delta).timeout

func _on_detection_area_body_entered(body):
	if body.is_moving == true:
		body.detected()
