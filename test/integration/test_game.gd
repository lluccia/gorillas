extends "res://addons/gut/test.gd"

var banana_scene = load("res://scenes/Banana.tscn")
var game_scene = load("res://scenes/Game.tscn")

var Banana = load("res://scripts/banana.gd")

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
    
    assert_eq(_game.get_node("HUD/game_over").text, "Game Over!\nPlayer 1 wins!")

func test_when_p2_hits_max_score_game_is_over():
    watch_signals(_game)

    _p2_scores()
    _p2_scores()
    _p2_scores()

    assert_signal_emitted(_game, "game_over")

    assert_eq(_game.get_node("HUD/game_over").text, "Game Over!\nPlayer 2 wins!")

func test_p1_is_first_to_play():
    assert_is_p1_turn()

func test_current_player_throws_banana():
    var current_player_position = _game._current_player.position
    
    var banana = _game.current_player_throw(45, 100)
    
    assert_eq(banana.position, Vector2(current_player_position.x,
                                       current_player_position.y - 20))

func test_game_over_not_visible_on_start():
    assert_false(_game.get_node("HUD/game_over").visible)

func test_when_banana_hits_killzone_its_next_player_turn():
    var killzone = _game.get_node("killzone")
    var banana = double(Banana).new()
    
    killzone.emit_signal("area_entered", banana)

    assert_is_p2_turn()

func test_when_p1_is_hit_its_p2_turn():
    _p1.emit_signal("hit", _banana)

    assert_is_p2_turn()

func test_when_p2_is_hit_its_p2_turn():
    _p2.emit_signal("hit", _banana)

    assert_is_p2_turn()

func test_after_2_hits_is_p1_again():
    _p2.emit_signal("hit", _banana)
    _p1.emit_signal("hit", _banana)

    assert_is_p1_turn()

func assert_is_p1_turn():
    assert_eq(_game._current_player, _p1, "current player should be Player 1")

func assert_is_p2_turn():
    assert_eq(_game._current_player, _p2, "current player should be Player 2")