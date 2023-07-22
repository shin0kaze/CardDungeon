## Класс для передачи данных анимаций
extends RefCounted
class_name AnimDTO



## Ссылка на анимируемый объект
var target: Object
## Значение анимируемого свойства
var val
## Название свойства
var prop: NodePath = "position"
## Время анимации
var dur: float  = .4
## Ускорение\замедление анимации
var ease: int = Tween.EASE_IN_OUT
## Ффункция перехода
var trans: int = Tween.TRANS_LINEAR
## Будет ли эта анимация запущена вместе с другими
var parallel: bool = false
## Вызов функции по окончании анимации
var callback: Callable



## Свойства свойства
func set_prop(value, prop_name: NodePath, target: Object = null)->AnimDTO:
	self.target = target
	val = value
	prop = prop_name
	return self

## Свойства анимации
func set_anim(duration: float, easing: int, transition: int)->AnimDTO:
	dur = duration
	ease = easing
	trans = transition
	return self

## Concurrent, будет ли эта анимация последовательной или парралельной
func set_conc(is_parallel:= true)->AnimDTO:
	parallel = is_parallel
	return self

## Устанавливает callback
func set_cb(callback:= default_cb)->AnimDTO:
	self.callback = callback
	return self

# Убирает callback
func unset_cb():
	self.callback = Callable()
	return self

## Callback по умолчанию
func default_cb():
	print("animation of "+ str(prop) + " to " + str(val) + " ended")

## Применяет свойства к Tween
func apply(tween: Tween, target: Object = null):
	if target:
		self.target = target
	if parallel:
		tween.parallel()
	tween.tween_property(self.target, prop, val, dur).set_ease(ease).set_trans(trans)
	if callback.is_valid():
		tween.tween_callback(callback)
