extends Area2D

export (Vector2) var _extents = Vector2(50,100) setget set_extents, get_extents 
signal hit

var _color = Color.red
var _top_left_position
    
func get_color():
    return _color

func set_color(color):
    _color = color

func set_size(size):
    set_extents(Vector2(size.x / 2, size.y / 2))

func get_extents():
    return _extents
    
func set_extents(extents):
    _extents = extents    

func _ready():
    var shape = RectangleShape2D.new()
    shape.extents = _extents
    $Shape.set_shape(shape)

func _draw():
    var e = $Shape.shape.extents
    draw_rect(Rect2(e.x * -1, e.y * -1, e.x * 2, e.y * 2), _color)

func _on_Building_area_entered(_area):
    emit_signal("hit")
