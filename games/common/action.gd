## Действие, которое можно вызывать отложенно
extends Node
class_name Action



## Порядок на исполнение, если в очереди
var order: int = 500
var message: StringName = "Unknown action"
## Сигнал, который имеет источникк, на который можено подписаться.
var signalToSubscribe: Signal
## Не имеет ли функция сайд эффектов, которые нужно выполнить перед вызовом следующей
var pure:
	get:
		bool(signalToSubscribe == null)
## Если функции можно запускать параллельно несмотря на сайдэффекты,
## у них должен быть совместимый id
var compatible_id: int = -1
## Действие которое нужно выполнить
var funcref: Callable
## Аргументы функции
var funcargs: Array



## Вызывает функцию с аргументы
func execute():
	funcref.callv(funcargs)

## Вызывает функцию и проверяет наличие сигнала
func execute_and_check():
	funcref.callv(funcargs)
	assert(signalToSubscribe, "Signal not found for %s" % message)

## Вызывает функцию и сигнал
func execute_and_notify():
	execute_and_check()
	signalToSubscribe.emit()
