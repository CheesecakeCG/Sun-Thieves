extends Node

signal hp_lost(delta : int)
signal hp_gained(delta : int)

@export var max_hp : float = 100: 
	set(v):
		max_hp = max(0, v)
		hp = hp
		
@export var hp : float = max_hp:
	set(v):
		v = clamp(v, 0, max_hp)
		if v > hp:
			hp_lost.emit(v-hp)
		else:
			if v < hp:
				hp_gained.emit(v-hp)
		hp = v

