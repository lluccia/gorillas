extends Node2D

var screen_width = 640
var screen_height = 350

var building_blocks = 60
var building_block_size = screen_width / building_blocks

var window_size = Vector2(4, 7)
var window_distance = Vector2(10, 15)
var window_margin = Vector2(3, 3)

var min_width_blocks = 4
var max_width_blocks = 7

var min_height_pixels = 200
var max_height_pixels = 50

var rng = RandomNumberGenerator.new()

var bottom_margin = 14

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
        var building_width_blocks = rng.randi_range(min_width_blocks,max_width_blocks)
        var building_height_pixels = rng.randi_range(min_height_pixels,max_height_pixels)
        
        var building = ColorRect.new()
        building.color = building_colors[rng.randi_range(0, 2)]
        
        var building_size = Vector2(building_width_blocks * building_block_size, building_height_pixels - bottom_margin)
        building.set_size(building_size)
        
        var building_position = Vector2(current_x, screen_height - building_height_pixels)
        building.set_position(building_position)

        building.add_to_group("buildings")
        
        add_child(building)
        _add_windows(building)
        
        current_x += building_width_blocks * building_block_size + 1
        building_blocks -= building_width_blocks

func _add_windows(building):
    var current_position = Vector2(building.get_position().x + window_margin.x, 
                                   building.get_position().y + window_margin.y)
    
    while (current_position.x < building.get_position().x + building.get_size().x - window_size.x ):
        while (current_position.y < building.get_position().y + building.get_size().y - window_size.y):
            
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
        current_position.y = building.get_position().y + window_margin.y
        
    
