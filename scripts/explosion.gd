extends Node2D

func playGorillaExplosion():
    $ratio.scale = Vector2(1, 0.46)
    $Animation.play("gorilla_explosion")

func playBuildingExplosion():
    $ratio.scale = Vector2(1, 1)
    $Animation.play("building_explosion")
