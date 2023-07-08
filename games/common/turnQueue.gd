## Очередь для действий
extends Node
class_name TurnQueue

## Вызывается когда закончились все действия
signal turn_completed
## Очередь действий
var queue: Array[Action]
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
			action.signalToSubscribe.connect(pop)
			break
		action = queue.pop_back()
	if not action:
		turn_completed.emit()



