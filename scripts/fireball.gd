tool

extends Node2D

export var radius = 32

var colors = [Color.red, Color.orange]

func _draw():
    for i in range(radius, 1, -1):
        draw_circle(Vector2(0,0), i, colors[i % 2])

func _process(delta):
    update()
