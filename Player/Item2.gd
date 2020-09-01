extends TextureProgress



onready var ico2 = $Item2
onready var ico1 = $Item1

func on_health_updated(value):
	ico2.value = value
	ico1.value = abs(value-1)
