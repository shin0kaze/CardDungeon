## Оболочка содержащая сущности
extends Node2D
class_name Card



## Scene uid://2drjjot2y0th
const UID: int = 1902340667748967745
## Перемещатель сущностей
@onready var mover: MoveAnimation = %MoveAnimation
## Спрайт с рубашкой карты, позволяет получить размер
@onready var cardBack: Sprite2D = %Back
## onready игровое поле
var cardField: CardField


func _ready():
	var parent = self.get_parent()
	cardField = parent if parent is CardField else null
	cardBack = $"./Back"
	_if_root()



## Возвращает размер спрайта без учета масштаба Card
func size()->Vector2i:
	return Vector2i((cardBack.scale * cardBack.texture.get_size()).ceil())

## Возвращает размер спрайта
func size_scaled()->Vector2i:
	return Vector2i(self.scale * cardBack.scale * cardBack.texture.get_size().ceil())

## Делит общий путь на небольшие кусочки твинов с калбеками
func split(pos: Vector2i, bold_mode: bool = false):
	pass


func _if_root():
	if UTILS.if_main(self):
		mover.move(Vector2(300,80))


