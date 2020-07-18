extends Area2D

signal hit
signal dance_finished

func throw(banana, angle, speed):
    var angle_radians = deg2rad(angle)
    
    if angle < 90:
        _play_animation("throw_right")
    else:
        _play_animation("throw_left")
        
    var speed_x = speed * cos(angle_radians)
    var speed_y = speed * sin(angle_radians)

    banana.set_speed(Vector2(speed_x, -speed_y))

func dance():
    _play_animation("dance")
    for _i in range(7):
        $DanceMove.play()
        yield(get_tree().create_timer(0.5), "timeout")

func _play_animation(animation):
    if $AnimatedSprite:
        $AnimatedSprite.play(animation)
    
    
func _on_Gorilla_area_entered(banana):
    emit_signal("hit", banana)

func _on_AnimatedSprite_animation_finished():
    if $AnimatedSprite.animation == "dance":
        emit_signal("dance_finished")
        $AnimatedSprite.animation = "default"
