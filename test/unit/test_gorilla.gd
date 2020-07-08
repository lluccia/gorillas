extends "res://addons/gut/test.gd"

var Gorilla = load('res://scripts/gorilla.gd')
var Banana = load('res://scripts/banana.gd')

var _gorilla

func before_each():
    _gorilla = Gorilla.new()

func test_can_create_a_gorilla():
    assert_not_null(_gorilla)

func test_gorilla_can_throw_a_banana_at_x_dir():
    var banana = double(Banana).new()
    stub(banana, 'set_speed').to_do_nothing()
    
    var angle = 0
    var speed = 100

    _gorilla.throw(banana, angle, speed)
    
    var speed_set = get_call_parameters(banana, 'set_speed', 0)[0]
    assert_eq(speed_set.x, 100)

func test_gorilla_can_throw_a_banana_at_y_dir():
    var banana = double(Banana).new()
    stub(banana, 'set_speed').to_do_nothing()

    var angle = 90
    var speed = 50
    _gorilla.throw(banana, angle, speed)

    var speed_set = get_call_parameters(banana, 'set_speed', 0)[0]
    assert_eq(speed_set.y, 50)

