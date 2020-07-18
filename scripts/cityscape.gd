extends Node2D

signal hit

var BuildingScene = load("res://scenes/Building.tscn")

var screen_width = 640
var screen_height = 350

var building_blocks = 63
var building_block_size = 10

var window_size = Vector2(4, 7)
var window_distance = Vector2(10, 15)
var window_margin = Vector2(3, 3)

var min_width_blocks = 4
var max_width_blocks = 7

var min_height_pixels = 200
var max_height_pixels = 50

var rng = RandomNumberGenerator.new()

var bottom_margin = 14
var buildings_baseline = screen_height - bottom_margin

var building_colors = [
    Color("#ffa80000"),
    Color("#ff00a8a8"),
    Color("#ffa8a8a8")
]

var light_on = Color("#fffcfc54")
var light_off = Color("#ff545454")

var lights_on_percentage = 0.7

func generate():
    rng.randomize()

    var current_x = 0
    
    while (building_blocks > 0):
        var building_width_blocks = min(building_blocks, rng.randi_range(min_width_blocks, max_width_blocks))

        var building_width_pixels = building_width_blocks * building_block_size
        var building_height_pixels = rng.randi_range(min_height_pixels,max_height_pixels)
        
        var building = BuildingScene.instance()
        building.set_color(building_colors[rng.randi_range(0, 2)])
        
        var bottom_left_corner = Vector2(current_x, buildings_baseline)

        var building_position = bottom_left_corner + Vector2(building_width_pixels / 2, -building_height_pixels / 2)
        building.set_position(building_position)
        building.set_size(Vector2(building_width_pixels, building_height_pixels))

        building.add_to_group("buildings")
        building.connect("area_entered", self, "_on_Building_hit")
        
        add_child(building)
        _add_windows(building)

        current_x += building.get_extents().x * 2 + 1
        building_blocks -= building_width_blocks

func _add_windows(building):
    var current_position = building.get_position() - building.get_extents() + window_margin
    
    while (current_position.x < building.get_position().x + building.get_extents().x - window_size.x ):
        while (current_position.y < building.get_position().y + building.get_extents().y - window_size.y):
            
            var window = ColorRect.new()
            
            var light_on_off = rng.randf()
            
            if (light_on_off < lights_on_percentage):
                window.color = light_on
            else:
                window.color = light_off
            
            var window_position = Vector2(current_position.x, current_position.y)
            window.set_position(window_position)
            
            window.set_size(window_size)
            
            add_child(window)
            
            current_position.y += window_distance.y
            
        current_position.x += window_distance.x
        current_position.y = building.get_position().y - building.get_extents().y + window_margin.y
        
    
func _on_Building_hit(banana):
    emit_signal("hit", banana)
