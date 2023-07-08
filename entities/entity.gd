extends Resource
var i = ResourceUID
var t = self.get_local_scene()
# ## Базовая сущность, от которой нужно наследоваться
# extends Node
# class_name Entity
# ## Спрайт существа, а в дальнейшем возможно сцена
# var sprite = null
# ## Название существа
# var entname: StringName = "entity"
# ## Можно ли на карту наступать
# var passable := true
# ## Карта для управления анимациями
# var card : Card
# ## Позиция карты на поле
# var field_position := -Vector2i.ONE
# ## Желаемое направление
# var desired_direction := Vector2i.ZERO
# ## Игровое поле
# @onready var field: CardField = find_parent("CardField")

# ## Получение карты, содержащей данную сущность
# func init(card_parent: Card):
# 	card = card_parent

# # Применяет эффект карты к вызывающему
# func apply(_can_move: bool = true, _that: Entity = null):
# 	pass

# # Указывает желаемое направление по названию анимации
# func move_start(direction: Vector2i) -> void:
# 	desired_direction = direction
# 	Events.lock_changed.emit(true)
# 	card.move(direction)

# ## Вызывается в середине анимации
# func check_move():
# 	var entity := field.take(field_position + desired_direction)
# 	var can_move := entity != null && entity.passable
# 	if not can_move:
# 		card.reverse()
# 		desired_direction = Vector2i.ZERO
# 	# fix that
# 	if entity != null:
# 		act(can_move)

# ## Инициирует взаимодействие с другой сущностью
# func act(can_move: bool):
# 	var entity = field.take(field_position + desired_direction)
# 	entity.apply(can_move, self)

# ## Вызывается в конце анимации, если ход успешен
# func move_end_suc():
# 		call_deferred("move_card")
# 		var old_pos = field.replace(field_position + desired_direction, self)
# 		card.idle()
# 		Events.lock_changed.emit(false)
# 		Events.cell_freed.emit(old_pos)

# ## Вызывается в конце анимации, если ход неудался
# func move_end_rep():
# 		card.idle()
# 		Events.lock_changed.emit(false)
# ## Перемещает карту на нужную позицию
# func move_card():
# 	card.place(desired_direction)

# func _exit_tree():
# 	card.queue_free()
