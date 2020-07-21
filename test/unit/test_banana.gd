extends "res://addons/gut/test.gd"

var Banana = load('res://scripts/banana.gd')
var _banana

func before_each():
    _banana = Banana.new()

func after_each():
    _banana.free()

func test_can_create_banana():
    assert_not_null(_banana)

func test_get_set_speed():
    assert_accessors(_banana, 'speed', Vector2(0, 0), Vector2(1, 1))

func test_get_set_gravity():
    assert_accessors(_banana, 'gravity', 0, 10)

func test_get_set_wind():
    assert_accessors(_banana, 'wind', 0, 10)

func test_banana_falls_with_gravity():
    _banana.set_gravity(10)

    simulate(_banana, 1, 1)

    assert_eq(_banana.get_position().y, 10.0)

func test_banana_moves_on_x_direction():
    _banana.set_speed(Vector2(10, 0))
    
    simulate(_banana, 1, 1)
    
    assert_eq(_banana.get_position().x, 10.0)

func test_banana_is_affected_by_wind():
    _banana.set_speed(Vector2(10, 0))
    _banana.set_wind(-5)
    
    simulate(_banana, 1, 1)
    
    assert_eq(_banana.get_position().x, 5.0)

func test_banana_is_lost_if_falls_below_screen_limits():
    _banana.set_position(Vector2(10, 340))
    _banana.set_gravity(10)
    watch_signals(_banana)

    simulate(_banana, 2, 1)
    
    assert_signal_emitted_with_parameters(_banana, "lost", [_banana])