extends Area2D

signal lost

var _speed = Vector2(0, 0)
var _gravity = 0
var _wind = 0

func get_speed():
    return _speed

func set_speed(speed):
    _speed = speed

func get_gravity():
    return _gravity

func set_gravity(gravity):
    _gravity = gravity

func get_wind():
    return _wind

func set_wind(wind):
    _wind = wind
    
func _process(delta):
    _speed.y = _speed.y + _gravity * delta
    _speed.x = _speed.x + _wind * delta

    set_position(Vector2(get_position().x + _speed.x * delta, get_position().y + _speed.y * delta))

    if position.y > 350:
        emit_signal("lost", self)
