func throw(banana, angle, speed):
    var angle_radians = deg2rad(angle)

    var speed_x = speed * cos(angle_radians)
    var speed_y = speed * sin(angle_radians)

    banana.set_speed(Vector2(speed_x, speed_y))