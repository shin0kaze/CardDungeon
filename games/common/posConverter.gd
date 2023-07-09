## Класс преобразующий положение на поле в координаты на экране и обратно
class_name PosConverter extends RefCounted



## Размер по умолчанию
var default_aabb: Vector2i
## Отступ по умолчанию
var default_margin : Vector2i



## Конструктор, принимающий размер по умолчанию и отступ
func _init(aabb: Vector2i = Vector2i(120, 150), margin: Vector2i = MATH.Vec2ixy(4)):
		default_aabb = aabb
		default_margin = margin



## Переводит из положения в двумерном массиве на координаты на экране
func xy_pos(xy_coord: Vector2i, aabb:=default_aabb, margin:=default_margin):
		var screen_coord: = margin + aabb
		screen_coord.x = screen_coord.x * xy_coord.x - margin.x
		screen_coord.y = screen_coord.y * xy_coord.y - margin.y
		return screen_coord

## Переводит из координат на экране в положение в массиве
func pos_xy(pos_coord: Vector2, aabb:=default_aabb, margin:=default_margin):
		var xy_coord: = Vector2i(pos_coord) + margin
		xy_coord.x /= aabb.x + margin.x
		xy_coord.y /= aabb.y + margin.y
		return xy_pos
