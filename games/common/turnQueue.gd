## Очередь для действий
extends Node
class_name TurnQueue



## Очередь действий
var queue: Array[Action]



func _init():
	BUS.unpure_turn_part_ended.connect(pop)



## Положить действие в очередь
func put(action: Action):
	queue.push_back(action)

## Сравнивает действия по приоритету, если приоритет равный, выбирается наугад.
func compare(action1: Action, action2: Action) -> int:
	if action1.order < action2.order:
		return true
	elif action1.order == action2.order:
		return bool(randi() % 2)
	else: return false

## Сортирует задачи перед запуском
func sort():
	queue.sort_custom(compare)

## Начинает обход очереди действий
func start():
	sort()
	pop()

## Достает очередной элемент из очереди, вызывает сигнал, если очередь пуста
func pop():
	var action: Action = queue.pop_back()
	while action:
		action.execute()
		if not action.pure:
			break
		action = queue.pop_back()
	if not action:
		BUS.all_turns_completed.emit()



