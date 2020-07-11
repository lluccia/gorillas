extends "res://addons/gut/test.gd"

var CityscapeScene = load("res://scenes/Cityscape.tscn")
var BuildingScene = load("res://scenes/Building.tscn")

func test_cityscape_creates_buildings():
    var cityscape = CityscapeScene.instance()
    add_child(cityscape)

    cityscape.generate()
    var buildings = get_tree().get_nodes_in_group("buildings")
    
    assert_gt(buildings.size(), 0, 'at least one building was created')

    remove_child(cityscape)
    cityscape.free()