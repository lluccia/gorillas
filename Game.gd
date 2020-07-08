extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
    rng.randomize()
    
    $Cityscape.generate()
    place_gorillas()
    
    $Banana.set_speed(Vector2(80, -100))
    $Banana.set_gravity(30)

func place_gorillas():
    var buildings = get_tree().get_nodes_in_group("buildings")
    
    _place_gorilla($left_gorilla, buildings[rng.randi_range(1, 2)])
    _place_gorilla($right_gorilla, buildings[buildings.size() - rng.randi_range(1, 2) - 1])

func _place_gorilla(gorilla, building):
    var gorilla_height = gorilla.texture.get_size().x
    gorilla.position = Vector2(building.get_position().x + building.get_size().x / 2,
                               building.get_position().y - gorilla_height / 2 - 1)

