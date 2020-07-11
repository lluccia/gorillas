extends "res://addons/gut/test.gd"

var building_scene = load("res://scenes/Building.tscn")
var banana_scene = load("res://scenes/Banana.tscn")

func test_bulding_is_hit_by_a_banana():
    var building = building_scene.instance()
    var banana = banana_scene.instance()
    
    add_child(building)
    add_child(banana)
    
    building.set_position(Vector2(100, 200))

    banana.set_position(Vector2(100, 180))
    banana.set_gravity(10)

    yield(yield_to(building, "hit", 4), YIELD)
    
    assert_signal_emitted(building, "hit")
    
    remove_child(building)
    remove_child(banana)
    
    building.free()
    banana.free()
