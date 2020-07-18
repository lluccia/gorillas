extends Node2D

signal game_over

var banana_scene = load("res://scenes/Banana.tscn")

var _p1_score = 0
var _p2_score = 0
var _max_score = 3

var _gravity = 30

var _current_player

var rng = RandomNumberGenerator.new()

func _ready():
    rng.randomize()

    _current_player = $p1
    
    $Cityscape.generate()
    place_gorillas()
    
    $HUD/p1_input.visible = true
    $HUD/p2_input.visible = false
    $HUD/game_over.visible = false
    
func place_gorillas():
    var buildings = get_tree().get_nodes_in_group("buildings")
    
    _place_gorilla($p1, buildings[rng.randi_range(1, 2)])
    _place_gorilla($p2, buildings[buildings.size() - rng.randi_range(1, 2) - 1])

func _place_gorilla(gorilla, building):
    var gorilla_height = 30
    gorilla.set_position(Vector2(
            building.get_position().x,
            building.get_position().y - building.get_extents().y - gorilla_height / 2 - 1))

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

func current_player_throw(angle, speed):
    var banana = banana_scene.instance()
    add_child(banana)

    banana.set_gravity(_gravity)
    banana.set_position(Vector2(
            _current_player.position.x,
            _current_player.position.y - 20))

    if _current_player == $p2:
        angle = 180 - angle

    _current_player.throw(banana, angle, speed)
    $Sounds/Throw.play()

    return banana

func _switch_player():
    if _current_player == $p1:
        _current_player = $p2
    else:
        _current_player = $p1
    
    _show_current_player_input()

func _remove_banana(banana):
    remove_child(banana)
    banana.queue_free()

func _play_gorilla_hit():
    $Sounds/GorillaHit.play()
    yield($Sounds/GorillaHit, "finished")
    
func _gorilla_dance(player):
    player.dance()
    yield(player, "dance_finished")
    
func _on_p1_hit(banana):
    _p2_score += 1
    _update_score()

    _remove_banana(banana)
    yield(_play_gorilla_hit(), "completed")
    
    yield(_gorilla_dance($p2), "completed")

    _switch_player()

    if (_p2_score == _max_score):
        emit_signal("game_over", "2")

func _on_p2_hit(banana):
    _p1_score += 1
    _update_score()

    _remove_banana(banana)
    yield(_play_gorilla_hit(), "completed")
    
    yield(_gorilla_dance($p1), "completed")

    _switch_player()

    if (_p1_score == _max_score):
        emit_signal("game_over", "1")

func _on_building_hit(banana):
    _remove_banana(banana)
    $Sounds/BuildingHit.play()
    _switch_player()
    
func _show_current_player_input():
    if _current_player == $p1:
        $HUD/p1_input.visible = true
    else:
        $HUD/p2_input.visible = true

func _update_score():
    $HUD/score/score_label.text = str(_p1_score) + ">Score<" + str(_p2_score)

func _on_p1_input_throw(angle, speed):
    $HUD/p1_input.visible = false
    current_player_throw(angle, speed)

func _on_p2_input_throw(angle, speed):
    $HUD/p2_input.visible = false
    current_player_throw(angle, speed)

func _on_Game_game_over(winner):
    $HUD/p1_input.visible = false
    $HUD/p2_input.visible = false
    
    $HUD/game_over.text = "Game Over!\nPlayer %s wins!" % winner
    $HUD/game_over.visible = true

func _on_killzone_area_entered(banana):
    _remove_banana(banana)

    _switch_player()
