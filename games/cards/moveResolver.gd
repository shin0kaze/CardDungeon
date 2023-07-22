## Класс предназначенный для разрешения состояний на поле
class_name MoveResolver extends RefCounted



## Игровое поле
var cardField: CardField
## Очередь на действия перемещений
var moveQueue: Array



func _init(cardField: CardField):
	self.cardField = cardField

## Разрешает передвижения в очереди
func _process(_delta):
	var field_copy = cardField.take_field()
	for move in moveQueue:
		var card1_i = cardField.xy_i(move['move'].src)
		var card2_i = cardField.xy_i(move['move'].dst)
		var card1 = field_copy[card1_i]
		var card2 = field_copy[card2_i]
		field_copy[card2_i] = card1
		if move['swap_mode']:
			field_copy[card1_i] = card2
		cardField.replace(field_copy)



## Гарантирует, что добавленные перемещения на следующем тике игры будут добавлены одновременно
func add_move(move: Line2i, swap_mode: bool)->void:
	moveQueue.append({move: move, swap_mode: swap_mode})
