## Класс управляющий данными расположения карточек на поле
extends Node
class_name CardField

#region Свойства класса

## Размер игрового поля x в ширину, y в высоту
var size: Vector2i = Vector2i(0,0)
## Массив содержащий в себе карточки на поле
var field: Array = []
## Массив содержащий  в себе перемещения для разрешения.
var moves: Array = []
#end


#region Конструкторы и функции жизненного цикла

## Инициализирует поле указанного размера
func init(size_of_field: Vector2i) -> void:
	size = size_of_field
	field.resize(size.x * size.y)

## Инициализирует поле указанного размера, и заполняет его картами
func init_fill(size_of_field: Vector2i, cards: Array) -> void:
	init(size_of_field)
	fill(cards)

## Заполняет поле картами
func fill(cards: Array) -> void:
	for i in cards.size():
		var entity = cards[i] #Entity.new()
		var coord := to_coord(i)
		#overwrite(coord, entity)

#end

## Преобразует индекс в координаты
func to_coord(length: int) -> Vector2i: 
	@warning_ignore("integer_division")
	return Vector2i(length % size.x,length / size.x)

## Преобразует координаты в индекс
func to_len(coord: Vector2i) -> int:
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

## Проверяет наличие карты
func exists(coord: Vector2i) -> bool:
	return take(coord) != null

## Возвращает карту, или null, если такого объекта нет
func take(coord: Vector2i) -> Entity:
	if in_range(coord):
		return field[to_len(coord)]
	assert(in_range(coord), "Out of range from card field!")
	return null

## Возвращает карту обернутую в массив, или null, если такого объекта нет
func take1(coord: Vector2i)  -> Array[Entity]: return [take(coord)]

## Возвращает соседние карты в четырех основных направлениях
func take4(coord: Vector2i) -> Array[Entity]:
	var cards: Array[Entity] = []
	cards.append(take(coord + Vector2i.UP))
	cards.append(take(coord + Vector2i.LEFT))
	cards.append(take(coord + Vector2i.RIGHT))
	cards.append(take(coord + Vector2i.DOWN))
	return cards

## Возвращает соседние карты в четырех основных направлениях,
## а также карту по координатам
func take5(coord: Vector2i) -> Array[Entity]:
	var cards := take4(coord)
	cards.append(take(coord))
	return cards

## Возвращает соседние карты по диагонали
func takeX(coord: Vector2i) -> Array[Entity]:
	var cards: Array[Entity] = []
	cards.append(take(coord - Vector2i.ONE))
	cards.append(take(coord + C.MIR))
	cards.append(take(coord - C.MIR))
	cards.append(take(coord + Vector2i.ONE))
	return cards

## Возвращает соседние карты по диагонали, а также карту по координатам
func takeX1(coord: Vector2i) -> Array[Entity]:
	var cards := takeX(coord)
	cards.append(take(coord))
	return cards

## Возвращает все соседние карты по часовой стрелке начиная с левой верхней
func take8(coord: Vector2i) -> Array[Entity]:
	var cards: Array[Entity] = []
	cards.append_array(takeX(coord))
	cards.append_array(take4(coord))
	return cards

## Возращает массив карт 3*3, coord указывает на центр
func take9(coord: Vector2i) -> Array[Entity]:
	var cards := take8(coord)
	cards.append(take(coord))
	return cards

## Возвращает строку из карт
## Если 1 параметр, берет всю строку, если 2, от coord.x до range_coord.x
func take_x(coord: Vector2i,  range_coord := -Vector2i.ONE) -> Array[Entity]:
	var cards: Array[Entity] = []
	if range_coord.x == -1:
		for i in size.x:
			var target_coord = C.Vec2ixy(i, coord)
			cards.append(take(target_coord))
	else:
		for i in range(coord.x, range_coord.x):
			var target_coord = C.Vec2ixy(i, coord)
			cards.append(take(target_coord))
	return cards

## Возвращает столбец из карт
## Если 1 параметр, берет весь столбец, если 2, от coord.y до range_coord.y
func take_y(coord: Vector2i, range_coord := -Vector2i.ONE) -> Array[Entity]:
	var cards: Array[Entity] = []
	if range_coord.y == -1:
		for i in size.y:
			var target_coord = C.Vec2ixy(coord, i)
			cards.append(take(target_coord))
	else:
		for i in range(coord.y, range_coord.y):
			var target_coord = C.Vec2ixy(coord, i)
			cards.append(take(target_coord))
	return cards

## Возвращает массив карт по основной диагонали
func take_diag(coord: Vector2i) -> Array[int]:
	var cards: Array[int] = []
	# Находим ближайшую координату к краю поля
	# Что бы взять крайнюю ячейку
	var first_coord := coord - C.Vec2ixy(C.minc(coord))
	var final_coord = C.Vec2ixy(C.minc(size - first_coord))

	var target_coord = first_coord
	while  target_coord < final_coord:
		C.dv(target_coord, "target_coord")
		cards.append(take(target_coord))
		target_coord += Vector2i(1,1)
	return cards

## Возвращает массив карт по основной диагонали
func take_diag_s(coord: Vector2i) -> Array[int]:
	var cards: Array[int] = []
	# Находим ближайшую координату к краю поля
	# Что бы взять крайнюю ячейку
	var first_coord := coord - C.Vec2ixy(C.minc(coord))
	var final_coord = C.Vec2ixy(C.minc(size - first_coord - Vector2i.ONE))
	var _spread = C.mixc(first_coord, final_coord)
	var a = _spread[0]
	var b = _spread[1]
	
	var target_coord = a
	while  target_coord <= b:
		cards.append(take(target_coord))
		target_coord += C.MIR
	return cards

# Возращает массив карт в виде прямоугольника, необходимо указать
# верхний левый угол и правый нижний
func take_rect(_coord_high: Vector2i, _coord_low: Vector2i) -> Array[Entity]:
	return []
# Возращает массив карт в виде ромба, необходимо указать
# верхнюю вершину фигуры и нижнюю
func take_romb(_coord_high: Vector2i, _coord_low: Vector2i) -> Array[Entity]:
	return []

## Возвращает массив карт в четырех основных направлениях с указанной длинной
func take_cross(_coord: Vector2i, _length: int = 12) -> Array[Entity]:
	return []

# Возвращает массив карт в четырех диагональных направлениях с указанной длинной
func take_diagX(_coord: Vector2i, _length: int = 12) -> Array[Entity]:
	return []
	#var cards = take_romb(coord-Vector2i(length, length), coord).reverse()
	#cards.append_arraay(take_romb(coord, coord+Vector2i(length, length)))
	#cards.append_arraay(take_romb(coord, coord+Vector2i(length, length)).reverse())
	#cards.append_arraay(take_romb(coord, coord+Vector2i(length, length)))

# Возращает массив карт в восьми направлениях с указанной длинной
func take_star(_coord: Vector2i, _length: int = 12) -> Array[Entity]:
	return []

## Возвращает все поле
func take_field() -> Array[Entity]:
		return field.duplicate()
## Применяет все действия доступные на данный момент
func resolve():
	for move in moves:
		move.apply()
#end



#region Функции перемещения карт

## Записывает карту по указанному индексу
#func write(coord: Vector2i, card: Entity) -> void:
#	field[to_len(coord)] = card
#	if card:
#		card.field_position = coord
#
### Удаляет карту с поля, и возвращает его для дальнейшей работы
#func remove(coord: Vector2i) -> Entity:
#	var card := take(coord)
#	if card:
#		write(coord, null)
#		card.field_position = -Vector2i.ONE
#	return card
#
### Перемещает карту, возвращая старую
#func move(coord: Vector2i, card: Entity) -> Entity:
#	var old_card := remove(coord)
#	if card.field_position != -Vector2i.ONE:
#		remove(card.field_position)
#	write(coord, card)
#	return old_card
#
### Удаляет карту с поля, и вызыввает очистку ресурсов
#func delete(coord: Vector2i) -> void:
#	var card := remove(coord)
#	if card != null:
#		card.queue_free()
#
### Записывает карту на поле удаляя предыдущую карту
### Как правило используется при первом появлении на поле
#func overwrite(coord: Vector2i, card: Entity) -> void:
#	if exists(coord):
#		delete(coord)
#	write(coord, card)
#
### Записывает карту на поле удаляя предыдущую карту
### Убирает карту со своего предыдущего положения
#func replace(coord: Vector2i, card: Entity) -> Vector2i:
#	delete(coord)
#	var old_coord = card.field_position
#	move(coord, card)
#	return old_coord
#
### Записывает карту на поле возвращая предыдущую карту
### Убирает карту со своего предыдущего положения
#func replace_from(coord_from: Vector2i, coord_to: Vector2i, del_need: bool = true) -> Entity:
#	var old_card
#	if del_need:
#		delete(coord_from)
#	var card := take(coord_from)
#	old_card = move(coord_to, card)
#	return old_card
#
### Меняет две карты местами
#func swap(coord1: Vector2i, coord2: Vector2i) -> void:
#	if exists(coord1) and exists(coord2):
#		var card1 := take(coord1)
#		var card2 := move(coord2, card1)
#		write(coord1, card2)
#
### Смещает карты влево или вправо, если второй аргумент опущен, 
### смещается вся строка, если он равен MIR, сдвиг в обратную сторону
#func shift_x(coord_from :=Vector2i.ZERO, coord_to := -Vector2i.ONE) -> Entity:
#	var card := remove(coord_from)
#	if coord_to == -Vector2i.ONE:
#		for i in range(size.x - 1, 1):
#			replace_from(C.Vec2ixy(i - 1, coord_from), C.Vec2ixy(coord_from, i))
#	elif coord_to == C.MIR:
#		for i in range(1, size.x - 1):
#			replace_from(C.Vec2ixy(i, coord_from), C.Vec2ixy(coord_from, i - 1))
#	else:
#		for i in range(coord_to.x, coord_from.x + 1):
#			replace_from(C.Vec2ixy(i - 1, coord_from), C.Vec2ixy(coord_from, i))
#	return card
#
### Смещает карты вверх или вниз, если второй аргумент опущен, 
### смещается весь столбец, если он равен MIR, сдвиг в обратную сторону
#func shift_y(coord_from :=Vector2i.ZERO, coord_to := -Vector2i.ONE) -> Entity:
#	var card := remove(coord_from)
#	if coord_to == -Vector2i.ONE:
#		for i in range(size.y - 1, 1):
#			replace_from(C.Vec2ixy(coord_from, i - 1), C.Vec2ixy(coord_from, i))
#	elif coord_to == C.MIR:
#		for i in range(1, size.y - 1):
#			replace_from(C.Vec2ixy(coord_from, i), C.Vec2ixy(coord_from, i - 1))
#	else:
#		for i in range(coord_to.y, coord_from.y + 1):
#			replace_from(C.Vec2ixy(coord_from, i - 1), C.Vec2ixy(coord_from, i))
#	return card
#
### Смещает карты влево или вправо ставя на пустое место первую карту,
### если второй аргумент опущен, смещается вся строка,
### если он равен MIR, сдвиг в обратную сторону
#func roll_x(coord_from :=Vector2i.ZERO, coord_to := -Vector2i.ONE):
#	var card = shift_x(coord_from, coord_to)
#	var coord := C.Vec2ixy(0, coord_from) if coord_to == -Vector2i.ONE else \
#			C.Vec2ixy(size.x -1, coord_from) if coord_to == C.MIR else coord_from
#	write(coord ,card)
#
###  Смещает карты вверх или вниз ставя на пустое место первую карту,
### если второй аргумент опущен, смещается весь столбец,
### если он равен MIR, сдвиг в обратную сторону
#func roll_y(coord_from :=Vector2i.ZERO, coord_to := -Vector2i.ONE):
#	var card = shift_y(coord_from, coord_to)
#	var target_coord := C.Vec2ixy(coord_from, 0) if coord_to == -Vector2i.ONE else \
#			C.Vec2ixy(coord_from, size.y -1) if coord_to == C.MIR else coord_from
#	write(target_coord ,card)
#
### Перемешивает поле, проценты определяют силу перемешивания от 0 до 100
#func shuffle(percent: int = 100):
#	if percent == 100:
#		field.shuffle()
#		for i in field:
#			field[i].field_position = to_coord(i)
#	else:
#		pass

#end
