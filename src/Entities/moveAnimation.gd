extends Node
## В отличии от обычной анимации этот класс сохраняет положение после анимации
class_name MoveAnimation

var tween: Tween = Tween.new().bind_node(self)
@onready var parent: Node2D = $"../"


func _ready():
	tween.set_pause_mode(Tween.TWEEN_PAUSE_STOP)
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)

func move(pos: Vector2, dur: float = 0.4, easing: int = Tween.EASE_IN_OUT, trans: int = Tween.TRANS_LINEAR):
	tween.tween_property(parent, "position", pos, dur).set_ease(easing).set_trans(trans)
