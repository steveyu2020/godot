extends Control
signal passed_on
var player = preload("res://player.tscn")
@onready var innocent = preload("res://innocent.tscn")
func set_time(new_time): # this is time in centiseconds 
	new_time = int(new_time)
	var timestr = str(new_time/100)+"." 
	if (new_time%100 < 10): 
		timestr += "0" 
	timestr += str(new_time%100) 
	$Gameover/time_survived.text = "You survived for: " + timestr + ' seconds'
	#func _ready():
	#new_innocent = innocent.instantiate()
	#self.add_child(new_innocent)
#func set_time(new_time): # this is time in centiseconds 
	#new_time = int(new_time)
	#var timestr = str(new_time/100)+"." 
	#if (new_time%100 < 10): 
		#timestr += "0" 
	#timestr += str(new_time%100) 
	#$Gameover/time_survived.text = "You survived for: " + timestr + ' seconds'
	
func _on_button_pressed():
	WasSplashscreenShowed.is_it_enemy = false
	self.hide()
