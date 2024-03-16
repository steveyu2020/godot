extends Node2D
@onready var enemy = $enemy
@onready var player = $player
@onready var splashscreen = $CanvasLayer/splashscreen
@onready var startscreen = $"UI/CanvasLayer2/start background"
@onready var camera = $camera_center/Camera2D
@onready var ui = $UI/CanvasLayer2
@onready var innocent = $innocent
var gos_scene = preload("res://game_over.tscn")
func _ready():
	if WasSplashscreenShowed.WasSplashscreenShowed == false:
		await get_tree().create_timer(2).timeout
		splashscreen.hide()
		WasSplashscreenShowed.WasSplashscreenShowed = true
	else:
		splashscreen.hide()


func _on_button_pressed():
	startscreen.hide()
	player.startmoving = true
	enemy.start = true 
	
	


func _on_enemy_done():
	await get_tree().create_timer(1).timeout
	var gos = gos_scene.instantiate()
	ui.add_child(gos)
	gos.set_time(round(timer*100)) 

var timer = 0.0 
func _physics_process(_delta): 
	if WasSplashscreenShowed.is_it_enemy == false:
		innocent.show()
	if (is_instance_valid(player) and player.startmoving): 
		timer += _delta 

	
	

