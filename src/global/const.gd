## Здесь лежат общие константы и функции
extends Node

## Вектор, где x = 1, y = -1
const MIR = Vector2i(1, -1)

## Значение для дебага по умолчанию
const _print_dbg := true 

## Создает int вектор на основе координат или чисел. 
## Если одно из них null, то оно будет равно противоположному.
## Если оба, то создается Vector2i(0, 0)
func Vec2ixy(x = null, y = null) -> Vector2i:
	var vx: int = 0
	var vy: int = 0
	
	if x is int:
		vx = x
	elif x is Vector2i:
		vx = x.x
	elif x is Vector2:
		vx = int(x.x)
	elif x is float:
		vx = int(x)

	if y is int:
		vy = y
	elif y is Vector2i:
		vy = y.y
	elif y is Vector2:
		vy = int(y.y)
	elif y is float:
		vy = int(y)

	if x == null:
		vx = vy
	if y == null:
		vy = vx
	return Vector2i(vx, vy)
	
## Преобразует индекс в координаты для произвольного поля
func i_xy(length: int, arr2d: Vector2i) -> Vector2i: 
	@warning_ignore("integer_division")
	return Vector2i(length % arr2d.x, length / arr2d.x)

## Преобразует координаты в индекс
func xy_i(coord: Vector2i, arr2d: Vector2i) -> int:
	return coord.x + coord.y * arr2d.x

## Создает вектор на основе StringName
func sn_Vec2i(s: StringName) -> Vector2i:
	match s:
		"lefttop", "lt": return -Vector2i.ONE
		"up", "t": return Vector2i.UP
		"righttop", "rt": return MIR
		"left", "l": return Vector2i.LEFT
		"center", "c": return Vector2i.ZERO
		"another", "a": return Vector2i.ZERO
		"right", "r": return Vector2i.RIGHT
		"leftdown", "lb": return -MIR
		"down", "b": return Vector2i.DOWN
		"rightdown", "rb": return Vector2i.ONE
	return Vector2i.ZERO

## Создает StringName на основе вектора
func Vec2i_sn(v: Vector2i, short := false) -> StringName:
	match v:
		-Vector2i.ONE: return StringName("lefttop") if short else StringName("lt")
		Vector2i.UP: return StringName("up") if short else StringName("t")
		MIR: StringName("rightup") if short else StringName("rt")
		Vector2i.LEFT: return StringName("left") if short else StringName("l")
		Vector2i.ZERO: return StringName("center") if short else StringName("c")
		Vector2i.RIGHT: return StringName("right") if short else StringName("r")
		-MIR: return StringName("leftdown") if short else StringName("lb")
		Vector2i.DOWN: return StringName("down") if short else StringName("b")
		Vector2i.ONE: return StringName("rightdown") if short else StringName("rb")
	return StringName("another") if short else StringName("a")

func minc(v: Vector2i) -> int:
	return mini(v.x, v.y)

func maxc(v: Vector2i) -> int:
	return maxi(v.x, v.y)

func mixc(v1: Vector2i, v2: Vector2i = Vector2i.ZERO) -> Array[Vector2i]:
	print(v1)
	print(v2)
	return [Vector2i(v1.x, v2.y), Vector2i(v2.x, v1.y)]

## Выводит значение параметра если включен режим дебага
func dv(v, msg: String = "your variable", enabled := true):
	if _print_dbg && enabled:
		print("val of " + msg + " is " + str(v))

## Выводит сообщение если включен режим дебага
func dm(msg: String = "down_here!", enabled := true):
	if _print_dbg && enabled:
		print(msg)













