extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var life_time = get_tree().create_timer(5)
	life_time.timeout.connect(_kill_bullet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed = Vector2.UP.rotated(rotation) * 1500.0 * delta
	position += speed

func _kill_bullet() -> void:
	queue_free()
