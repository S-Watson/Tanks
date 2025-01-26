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
