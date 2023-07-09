## Класс ищущий нужные элементы на поле
class_name CardFinder extends RefCounted



## размеры поля
var size: Vector2i = Vector2i(0,0)
## Поле
var field: Array = [Card]



func _init(size: Vector2i = Vector2i(), field: Array[Card] = []):
	self.size = size
	self.field = field



## Преобразует индекс в координаты
func i_xy(index: int) -> Vector2i:
	if(index < 0):
		return -Vector2i.ONE
	@warning_ignore("integer_division")
	return Vector2i(index % size.x,index / size.x)

## Преобразует координаты в индекс
func xy_i(coord: Vector2i) -> int:
	return coord.x + coord.y * size.x

## Сравнивает что координата x не выходит за поле
func in_range_x(coord: Vector2i) -> bool:
	return coord.x >= 0 && coord.x < size.x

## Сравнивает что координата y не выходит за поле
func in_range_y(coord: Vector2i) -> bool:
	return coord.y >= 0 && coord.y < size.y

## Сравнивает что координаты не выходят за поле
func in_range(coord: Vector2i) -> bool:
	return coord.x >= 0 && coord.y >= 0 && coord.x < size.x && coord.y < size.y
#end



#region Функции получения карт



## Находит себя на поле
func find(card: Card) -> Vector2i:
	return i_xy(field.find(card))

## Находит только !null
func find_exists(card: Card) -> Vector2i:
	var coord:= find(card)
	return coord if exists(coord) else -Vector2i.ONE
## Проверяет наличие карты
func exists(coord: Vector2i) -> bool:
	return take(coord) != null

## Возвращает карту, или null, если такого объекта нет
func take(coord: Vector2i) -> Card:
		return field[xy_i(coord)]

## Возвращает карту обернутую в массив, или [], если такого объекта нет
func take1(coord: Vector2i)  -> Array[Card]: return [take(coord)] if exists(coord) else []

## Возвращает соседние карты в четырех основных направлениях
func take4(coord: Vector2i) -> Array[Card]:
	var cards: Array[Card] = []
	cards.append(take(coord + Vector2i.UP))
	cards.append(take(coord + Vector2i.LEFT))
	cards.append(take(coord + Vector2i.RIGHT))
	cards.append(take(coord + Vector2i.DOWN))
	return cards

## Возвращает соседние карты в четырех основных направлениях, а также карту по координатам
func take5(coord: Vector2i) -> Array[Card]:
	var cards := take4(coord)
	cards.append(take(coord))
	return cards

## Возвращает соседние карты по диагонали
func takeX(coord: Vector2i) -> Array[Card]:
	var cards: Array[Card] = []
	cards.append(take(coord - Vector2i.ONE))
	cards.append(take(coord + MATH.Vector2iMIRR))
	cards.append(take(coord - MATH.Vector2iMIRR))
	cards.append(take(coord + Vector2i.ONE))
	return cards

## Возвращает соседние карты по диагонали, а также карту по координатам
func takeX1(coord: Vector2i) -> Array[Card]:
	var cards := takeX(coord)
	cards.append(take(coord))
	return cards

## Возвращает все соседние карты
func take8(coord: Vector2i) -> Array[Card]:
	var cards: Array[Card] = []
	cards.append_array(takeX(coord))
	cards.append_array(take4(coord))
	return cards

## Возращает массив карт 3*3, coord указывает на центр
func take9(coord: Vector2i) -> Array[Card]:
	var cards := take8(coord)
	cards.append(take(coord))
	return cards

## Возвращает строку из карт. Если 1 параметр, берет всю строку, если 2, от coord.x до range_coord.x
func take_x(coord: Vector2i,  range_coord := -Vector2i.ONE) -> Array[Card]:
	var cards: Array[Card] = []
	if range_coord.x == -1:
		for i in size.x:
			var target_coord = MATH.Vec2ixy(i, coord)
			cards.append(take(target_coord))
	else:
		for i in range(coord.x, range_coord.x):
			var target_coord = MATH.Vec2ixy(i, coord)
			cards.append(take(target_coord))
	return cards

## Возвращает столбец из карт. Если 1 параметр, берет весь столбец, если 2, от coord.y до range_coord.y
func take_y(coord: Vector2i, range_coord := -Vector2i.ONE) -> Array[Card]:
	var cards: Array[Card] = []
	if range_coord.y == -1:
		for i in size.y:
			var target_coord = MATH.Vec2ixy(coord, i)
			cards.append(take(target_coord))
	else:
		for i in range(coord.y, range_coord.y):
			var target_coord = MATH.Vec2ixy(coord, i)
			cards.append(take(target_coord))
	return cards

## Возвращает массив карт по побочной / диагонали
func take_diag_s(coord: Vector2i) -> Array[int]:
	var cards: Array[int] = []
	# Находим ближайшую координату к краю поля
	# Что бы взять крайнюю ячейку
	var first_coord := coord - MATH.Vec2ixy(MATH.minc(coord))
	var final_coord = MATH.Vec2ixy(MATH.minc(size - first_coord))

	var target_coord = first_coord
	while  target_coord < final_coord:
		MATH.dv(target_coord, "target_coord")
		cards.append(take(target_coord))
		target_coord += Vector2i(1,1)
	return cards

## Возвращает массив карт по основной \ диагонали
func take_diag(coord: Vector2i) -> Array[int]:
	var cards: Array[int] = []
	# Находим ближайшую координату к краю поля
	# Что бы взять крайнюю ячейку
	var first_coord := coord - MATH.Vec2ixy(MATH.minc(coord))
	var final_coord = MATH.Vec2ixy(MATH.minc(size - first_coord - Vector2i.ONE))
	var _spread = MATH.mixc(first_coord, final_coord)
	var a = _spread[0]
	var b = _spread[1]

## Возращает массив карт в виде прямоугольника, необходимо указать верхний левый угол и правый нижний
	var target_coord = a
	while  target_coord <= b:
		cards.append(take(target_coord))
		target_coord += MATH.MIR
	return cards

## Возращает массив карт в виде ромба, необходимо указать верхнюю вершину фигуры и нижнюю
func take_rect(_coord_high: Vector2i, _coord_low: Vector2i) -> Array[Card]:
	return []

## Возвращает массив карт в четырех основных направлениях с указанной длинной
func take_romb(_coord_high: Vector2i, _coord_low: Vector2i) -> Array[Card]:
	return []

## Возвращает массив карт в четырех диагональных направлениях с указанной длинной
func take_cross(_coord: Vector2i, _length: int = 12) -> Array[Card]:
	return []

func take_diagX(_coord: Vector2i, _length: int = 12) -> Array[Card]:
	return []

## Возращает массив карт в восьми направлениях с указанной длинной
func take_star(_coord: Vector2i, _length: int = 12) -> Array[Card]:
	return []

#endregion
