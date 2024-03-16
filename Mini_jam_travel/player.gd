extends CharacterBody2D
@export var speed = 400
var start = true
var is_moving = false
func _physics_process(_delta):
	if start == true:
		is_moving = false
		velocity = Vector2(0,0)
		if Input.is_action_pressed('up'):
			velocity = Vector2(0,-speed)
			is_moving = true
		if Input.is_action_pressed('down'):
			velocity = Vector2(0,speed)
			is_moving = true
		if Input.is_action_pressed("left"):
			velocity = Vector2(-speed,0)
			is_moving = true
		if Input.is_action_pressed('right'):
			velocity = Vector2(speed,0)
			is_moving = true
		move_and_slide()

func detected():
	start = false
	await get_tree().create_timer(2).timeout
	queue_free()
