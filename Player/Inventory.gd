extends Node2D

onready var ico1 = $Item1
onready var ico2 = $Item2
onready var ico3 = $Item3



func on_val_updated(value1, value2, value3):
	ico1.value = value1
	ico2.value = value2
	ico3.value = value3
