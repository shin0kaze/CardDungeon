## В отличии от обычной анимации этот класс сохраняет положение после анимации
extends Node
class_name MoveAnimation



## Твин для анимации свойства координат
@onready var tween: Tween = create_tween()
## Родительский объект, который нужно перемещать
@onready var parent: Card = self.get_parent()



func _ready():
	tween.bind_node(self)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_STOP)
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)



## Добавляет анимацию последовательно
func move(pos: Vector2 = parent.position, dur: float = 0.4, easing: int = Tween.EASE_IN_OUT, trans: int = Tween.TRANS_LINEAR):
	tween.set_parallel(false)
	tween.tween_property(parent, "position", pos, dur).set_ease(easing).set_trans(trans)
	return self

## Добавляет анимацию параллельно
func movp(pos: Vector2  = parent.position, dur: float = 0.4, easing: int = Tween.EASE_IN_OUT, trans: int = Tween.TRANS_LINEAR):
	tween.set_parallel(true)
	tween.tween_property(parent, "position", pos, dur).set_ease(easing).set_trans(trans)
	return self
