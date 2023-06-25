## Нода для быстрого запуска и проверки кода
extends Node2D

func _ready():
#	var timer := Timer.new()
#	add_child(timer)
#	timer.timeout.connect(run_code)
#	timer.autostart = true
#	timer.start(.6)
	C.dm("Code runned")

func run_code():
	@warning_ignore("unassigned_variable")
	var _pass
	var m = MoveAnimation.new()
	m
#	var o = take_diag_s(Vector2i(1,1))
#	print(o)
#
#
#var size = Vector2i(3,3)
#var field: Array = [
#		0,1,2,
#		3,4,5,
#		6,7,8,]
#
#func take(coord: Vector2i) -> int:
#	var i = coord.x + coord.y * size.x
#	return field[i]
#
#func take_diag(coord: Vector2i) -> Array[int]:
#	var cards: Array[int] = []
#	# Находим ближайшую координату к краю поля
#	# Что бы взять крайнюю ячейку
#	var first_coord := coord - C.Vec2ixy(C.minc(coord))
#
#	var final_coord = C.Vec2ixy(C.minc(size - first_coord))
#
#	var target_coord = first_coord
#	while  target_coord < final_coord:
#		C.dv(target_coord, "target_coord")
#		cards.append(take(target_coord))
#		target_coord += Vector2i(1,1)
#	return cards
#
### Возвращает массив карт по основной диагонали
#func take_diag_s(coord: Vector2i) -> Array[int]:
#	var cards: Array[int] = []
#	# Находим ближайшую координату к краю поля
#	# Что бы взять крайнюю ячейку
#	var first_coord := coord - C.Vec2ixy(C.minc(coord))
#	var final_coord = C.Vec2ixy(C.minc(size - first_coord - Vector2i.ONE))
#	var _spread = C.mixc(first_coord, final_coord)
#	var a = _spread[0]
#	var b = _spread[1]
#	var target_coord = a
#	while  target_coord <= b:
#		cards.append(take(target_coord))
#		target_coord += C.MIR
#	return cards



