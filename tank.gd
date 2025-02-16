extends Node2D

var rotation_speed = 3.0  # Radians per second
var move_speed = 1000.0   # Pixels per second

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TankTracksLeftSprite.play("default")
	$TankTracksRightSprite.play("default")


func _process(delta: float) -> void:
	# Rotation controls
	if Input.is_action_pressed("Move Right"):
		rotation += rotation_speed * delta
	
	if Input.is_action_pressed("Move Left"):
		rotation -= rotation_speed * delta
	
	# Movement based on current rotation
	var movement_direction = Vector2.UP.rotated(rotation)
	
	if Input.is_action_pressed("Move Up"):
		position += movement_direction * move_speed * delta
	
	if Input.is_action_pressed("Move Down"):
		position -= movement_direction * move_speed * delta
		
	 # Get tank's screen position
	var screen_position = $TankGunSprite.global_position

	# Get mouse position relative to the tank
	var mouse_position = get_global_mouse_position()

	# Calculate aim angle
	var aim_angle = screen_position.angle_to_point(mouse_position)  + PI / 2
	$TankGunSprite.global_rotation = aim_angle

	if Input.is_action_just_pressed("Shoot"):
		# load bullet
		var bullet_scene = preload("res://bullet.tscn")
		var bullet = bullet_scene.instantiate()
		# get position of bullet - move to center of gun then add rotation from there
		var tank_gun_position = $TankGunSprite.position
		var turret_tip_offset = Vector2(0, -200).rotated(aim_angle)
		bullet.position = position + tank_gun_position.rotated(rotation) + turret_tip_offset
		bullet.rotation = aim_angle
		# add bullet to scene
		get_parent().add_child(bullet)
