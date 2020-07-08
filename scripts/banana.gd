extends Area2D

var _speed = Vector2(0, 0)
var _gravity = 0

func get_speed():
    return _speed

func set_speed(speed):
    _speed = speed

func get_gravity():
    return _gravity

func set_gravity(gravity):
    _gravity = gravity
    
func _process(delta):
    _speed.y = _speed.y + _gravity * delta

    set_position(Vector2(get_position().x + _speed.x * delta, get_position().y + _speed.y * delta))
