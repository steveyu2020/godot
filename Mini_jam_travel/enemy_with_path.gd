extends Path2D
var speed = 0.2
var state = 'patrol'
@onready var pathfollow = $PathFollow2D
func patrol(delta):
	pathfollow.progress_ratio += speed*delta
func _physics_process(delta):
	patrol(delta)
func _on_timer_timeout():
	if speed != 1:
		speed += 0.1
