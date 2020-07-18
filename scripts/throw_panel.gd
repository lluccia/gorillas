extends Node2D

signal throw

func _on_throw_button_pressed():
    var angle = int($angle_input.text)
    var speed = int($speed_input.text)
    emit_signal("throw", angle, speed)
