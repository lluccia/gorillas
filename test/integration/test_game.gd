extends "res://addons/gut/test.gd"

var banana_scene = load("res://scenes/Banana.tscn")
var game_scene = load("res://scenes/Game.tscn")

var _game
var _banana

var _p1
var _p2

func before_each():
    _game = game_scene.instance()
    add_child(_game)
    _banana = banana_scene.instance()
    _game.add_child(_banana)

    _p1 = _game.get_node("p1")
    _p2 = _game.get_node("p2")

func after_each():
    remove_child(_game)
    _game.free()

func _p1_scores():
    _p2.emit_signal("hit", _banana)

func _p2_scores():
    _p1.emit_signal("hit", _banana)

func test_get_set_p1_score():
    assert_accessors(_game, 'p1_score', 0, 3)

func test_get_set_p2_score():
    assert_accessors(_game, 'p2_score', 0, 3)

func test_get_set_max_score():
    assert_accessors(_game, 'max_score', 3, 0)

func test_when_p1_is_hit_p2_score_increases():
    _p2_scores()

    assert_eq(_game.get_p2_score(), 1)

func test_when_p2_is_hit_p1_score_increases():
    _p1_scores()

    assert_eq(_game.get_p1_score(), 1)

func test_when_p1_hits_max_score_game_is_over():
    watch_signals(_game)

    _p1_scores()
    _p1_scores()
    _p1_scores()

    assert_signal_emitted(_game, "game_over")

func test_when_p2_hits_max_score_game_is_over():
    watch_signals(_game)

    _p2_scores()
    _p2_scores()
    _p2_scores()

    assert_signal_emitted(_game, "game_over")

func test_p1_is_first_to_play():
    assert_eq(_game._current_player, _p1)

func test_after_p1_throw_is_p2_turn():
    _game.current_player_throw(45, 100)
    
    assert_eq(_game._current_player, _p2)

func test_then_after_p2_is_p1_again():
    _game.current_player_throw(45, 100)
    _game.current_player_throw(45, 100)
    
    assert_eq(_game._current_player, _p1)

func test_current_player_throws_banana():
    var current_player_position = _game._current_player.position
    
    var banana = _game.current_player_throw(45, 100)
    
    assert_eq(banana.position, Vector2(current_player_position.x,
                                       current_player_position.y - 20))