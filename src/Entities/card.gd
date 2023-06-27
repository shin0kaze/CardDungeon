## Оболочка содержащая сущности
extends Node2D
class_name Card

@onready var mover: MoveAnimation = $"./MoveAnimation"

func _ready():
	if_root()

func if_root():
	if get_parent() == get_tree().get_root():
		mover.move(Vector2(300,80))
