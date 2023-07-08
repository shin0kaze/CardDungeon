## Оболочка содержащая сущности
extends Node2D
class_name Card

#Scene uid://2drjjot2y0th
var UID: int = 1902340667748967745

@onready var mover: MoveAnimation = $"./MoveAnimation"
@onready var cardBack: Sprite2D = $"./Back"

func _ready():
	_if_root()

## Возвращает размер спрайта без учета масштаба Card
func size()->Vector2i:
	return cardBack.scale * cardBack.texture.get_size()

## Возвращает размер спрайта
func size_scaled()->Vector2i:
	return self.scale * cardBack.scale * cardBack.texture.get_size()

func _if_root():
	if UTILS.if_main(self):
		mover.move(Vector2(300,80))
		var b = size()
		print(b)

