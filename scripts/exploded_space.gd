tool

extends Node2D

export var radius = 0

var background_color = Color("#0000a8")

func _draw():
    draw_circle(Vector2(0,0), radius, background_color)

func _process(delta):
    update()
