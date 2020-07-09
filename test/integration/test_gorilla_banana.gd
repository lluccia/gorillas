extends "res://addons/gut/test.gd"

var gorilla_scene = load("res://scenes/Gorilla.tscn")
var banana_scene = load("res://scenes/Banana.tscn")

func test_gorilla_is_hit_by_a_banana():
    var gorilla = gorilla_scene.instance()
    var banana = banana_scene.instance()
    
    add_child(gorilla)
    add_child(banana)
    
    gorilla.set_position(Vector2(100, 200))
    banana.set_position(Vector2(100, 180))
    banana.set_gravity(10)

    yield(yield_to(gorilla, "hit", 4), YIELD)
    
    assert_signal_emitted(gorilla, "hit")
    
    remove_child(gorilla)
    remove_child(banana)
    
    gorilla.free()
    banana.free()
