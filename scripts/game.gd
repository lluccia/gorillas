extends Node2D

signal game_over

var _p1_score = 0
var _p2_score = 0
var _max_score = 3
var _current_player

func _ready():
    _current_player = $p1

func get_p1_score():
    return _p1_score

func set_p1_score(p1_score):
    _p1_score = p1_score

func get_p2_score():
    return _p2_score

func set_p2_score(p2_score):
    _p2_score = p2_score
      
func get_max_score():
    return _max_score

func set_max_score(max_score):
    _max_score = max_score

func current_player_throw():
    if _current_player == $p1:
        _current_player = $p2
    else:
        _current_player = $p1

func _on_p1_hit():
    _p2_score += 1
    if (_p2_score == _max_score):
        emit_signal("game_over")

func _on_p2_hit():
    _p1_score += 1
    if (_p1_score == _max_score):
        emit_signal("game_over")
