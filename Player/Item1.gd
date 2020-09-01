extends TextureProgress

onready var ico1 = $Item1
onready var ico2 = $Item2

func on_health_updated(value):
	ico1.value = value
	ico2.value = abs(value-1)
