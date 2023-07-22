## Класс для линий, ходов, всего что можно указать двумя векторами
extends RefCounted
class_name Line2i



func _init(src := Vector2i(), dst := Vector2i()) -> void:
	self.src = src
	self.dst = dst



## Точка начала
var src: Vector2i
# Точка конца
var dst: Vector2i
## Алиас для точки начала
var a: Vector2i:
		set(new_a):
			src = new_a
		get:
			return src
## Алиас для точки конца
var b: Vector2i:
		set(new_b):
			dst = new_b
		get:
			return dst
## Длина линии в квадрате int
var lengthi_squared: int:
	get:
		return int(pow(dst.x - src.x,2) + pow(dst.y - src.y,2))
## Длина линии в квадрате float
var lengthf_squared: float:
	get:
		return pow(dst.x - src.x,2) + pow(dst.y - src.y,2)
## Длина линии int
var lengthi: int:
	get:
		return int(sqrt(pow(dst.x - src.x,2) + pow(dst.y - src.y,2)))
## Длина линии int
var lengthf: float:
	get:
		return sqrt(pow(dst.x - src.x,2) + pow(dst.y - src.y,2))
## Координаты линии
var ab: Array[Vector2i]:
	set(new_ab):
		src = new_ab[0]
		dst = new_ab[1]
	get:
		return [src, dst]
