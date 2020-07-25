extends Node2D

export var strength = 0
const _color = Color("#fc0054")

func _draw():
    draw_line(Vector2(0, 0), Vector2(strength, 0), _color)
    
    var wind_dir = 0
    if strength != 0:
        wind_dir = strength/abs(strength)
    
    draw_line(Vector2(strength, 0), Vector2(strength - (wind_dir * 3), -3), _color)
    draw_line(Vector2(strength, 0), Vector2(strength - (wind_dir * 3), 3), _color)
